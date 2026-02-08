#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdio.h> // Required for NULL, potentially for debugging, remove if not needed.
#include "uthash.h"

struct TrieNode;

typedef struct ChildEntry {
    char* name;
    struct TrieNode* node;
} ChildEntry;

int compare_child_entries(const void* a, const void* b) {
    const ChildEntry* entryA = (const ChildEntry*)a;
    const ChildEntry* entryB = (const ChildEntry*)b;
    return strcmp(entryA->name, entryB->name);
}

struct TrieNode {
    char* name;
    ChildEntry* children; // Dynamic array of ChildEntry
    int num_children;
    int capacity_children;
    unsigned long long subtree_hash; // Hash of the canonical representation of this subtree
    bool is_deleted; // Flag to mark if this folder (and its subtree) should be deleted
};

struct TrieNode* createTrieNode(const char* name) {
    struct TrieNode* node = (struct TrieNode*)malloc(sizeof(struct TrieNode));
    node->name = (name == NULL) ? NULL : strdup(name); // Root can have NULL name
    node->children = NULL;
    node->num_children = 0;
    node->capacity_children = 0;
    node->subtree_hash = 0;
    node->is_deleted = false;
    return node;
}

struct TrieNode* addChildToTrie(struct TrieNode* parent, const char* child_name) {
    // Check if child already exists using binary search
    ChildEntry key = { .name = (char*)child_name, .node = NULL };
    ChildEntry* found_entry = (ChildEntry*)bsearch(&key, parent->children, parent->num_children,
                                       sizeof(ChildEntry), compare_child_entries);
    if (found_entry) {
        return found_entry->node;
    }

    // Child does not exist, create new node and add it
    struct TrieNode* new_child_node = createTrieNode(child_name);

    // Resize children array if needed
    if (parent->num_children == parent->capacity_children) {
        parent->capacity_children = parent->capacity_children == 0 ? 4 : parent->capacity_children * 2;
        parent->children = (ChildEntry*)realloc(parent->children, parent->capacity_children * sizeof(ChildEntry));
    }

    // Find insertion point to maintain sorted order
    int i;
    for (i = 0; i < parent->num_children; ++i) {
        if (strcmp(child_name, parent->children[i].name) < 0) {
            break;
        }
    }

    // Shift elements to make space for the new child
    if (i < parent->num_children) {
        memmove(&parent->children[i + 1], &parent->children[i],
                (parent->num_children - i) * sizeof(ChildEntry));
    }

    // Insert the new child
    parent->children[i].name = new_child_node->name; // Use strdup'd name from new_child_node
    parent->children[i].node = new_child_node;
    parent->num_children++;

    return new_child_node;
}

void freeTrie(struct TrieNode* node) {
    if (!node) return;
    for (int i = 0; i < node->num_children; ++i) {
        freeTrie(node->children[i].node);
    }
    free(node->children);
    free(node->name);
    free(node);
}

struct HashCountEntry {
    unsigned long long hash_val;
    int count;
    UT_hash_handle hh; // For uthash
};
struct HashCountEntry* subtree_hash_counts = NULL; // Global uthash table

unsigned long long string_name_hash(const char* s) {
    unsigned long long h = 0;
    unsigned long long p = 31; // A prime number
    // No explicit modulus for unsigned long long, it wraps around naturally (effectively mod 2^64)
    while (*s) {
        h = h * p + (*s - 'a' + 1); // Assuming lowercase English letters
        s++;
    }
    return h;
}

unsigned long long dfs_calculate_hashes(struct TrieNode* node) {
    if (!node) return 0;

    // Calculate hash component for the current node's name
    unsigned long long current_node_hash_component = string_name_hash(node->name);
    unsigned long long P = 31; // Prime for combining hashes

    // Recursively calculate hashes for children and combine them
    // Children are already sorted by name, ensuring consistent hash calculation
    for (int i = 0; i < node->num_children; ++i) {
        unsigned long long child_subtree_h = dfs_calculate_hashes(node->children[i].node);
        current_node_hash_component = current_node_hash_component * P + child_subtree_h;
    }

    node->subtree_hash = current_node_hash_component;

    // Update hash counts in the global hash table
    struct HashCountEntry* entry;
    HASH_FIND_ULL(subtree_hash_counts, &node->subtree_hash, entry);
    if (entry == NULL) {
        entry = (struct HashCountEntry*)malloc(sizeof(*entry));
        entry->hash_val = node->subtree_hash;
        entry->count = 1;
        HASH_ADD_KEYPTR(hh, subtree_hash_counts, &entry->hash_val, sizeof(unsigned long long), entry);
    } else {
        entry->count++;
    }

    return node->subtree_hash;
}

void dfs_mark_deleted(struct TrieNode* node) {
    if (!node) return;

    struct HashCountEntry* entry;
    HASH_FIND_ULL(subtree_hash_counts, &node->subtree_hash, entry);

    // If the subtree hash count is greater than 1, mark for deletion
    if (entry != NULL && entry->count > 1) {
        node->is_deleted = true;
        return; // If this node is deleted, its children are implicitly deleted, so stop recursion
    }

    // Recurse on children if the current node is not deleted
    for (int i = 0; i < node->num_children; ++i) {
        dfs_mark_deleted(node->children[i].node);
    }
}

void dfs_collect_paths(struct TrieNode* node, char** current_path_segments, int depth,
                       char*** result_paths, int* result_count, int* result_capacity) {
    if (!node || node->is_deleted) {
        return;
    }

    // If not the dummy root, add the current folder's path to results
    if (depth > 0) {
        current_path_segments[depth-1] = node->name;

        // Resize result_paths array if needed
        if (*result_count == *result_capacity) {
            *result_capacity = (*result_capacity == 0) ? 10 : (*result_capacity * 2);
            *result_paths = (char***)realloc(*result_paths, (*result_capacity) * sizeof(char**));
        }

        // Create a new path array for the current result
        char** path = (char**)malloc((depth + 1) * sizeof(char*)); // +1 for NULL terminator
        for (int i = 0; i < depth; i++) {
            path[i] = strdup(current_path_segments[i]);
        }
        path[depth] = NULL; // Null-terminate the path segments array

        (*result_paths)[*result_count] = path;
        (*result_count)++;
    }

    // Recurse on children
    for (int i = 0; i < node->num_children; ++i) {
        dfs_collect_paths(node->children[i].node, current_path_segments, depth + 1,
                          result_paths, result_count, result_capacity);
    }
}

char*** deleteDuplicateFolders(char*** paths, int pathsSize, int* pathsColSize, int* returnSize, int** returnColumnSizes) {
    // Initialize global uthash table for subtree counts
    subtree_hash_counts = NULL;

    // Create a dummy root node for the trie (it doesn't represent an actual folder)
    struct TrieNode* root = createTrieNode(NULL);

    // Build the trie from the given paths
    for (int i = 0; i < pathsSize; ++i) {
        struct TrieNode* current_node = root;
        for (int j = 0; j < pathsColSize[i]; ++j) {
            current_node = addChildToTrie(current_node, paths[i][j]);
        }
    }

    // First DFS pass: Calculate subtree hashes and populate their counts
    // Start from children of the dummy root (top-level folders)
    for (int i = 0; i < root->num_children; ++i) {
        dfs_calculate_hashes(root->children[i].node);
    }

    // Second DFS pass: Mark duplicate subtrees for deletion
    // Start from children of the dummy root
    for (int i = 0; i < root->num_children; ++i) {
        dfs_mark_deleted(root->children[i].node);
    }

    // Third DFS pass: Collect paths of the remaining (non-deleted) folders
    // `current_path_segments` acts as a temporary buffer to build paths
    char** current_path_segments = (char**)malloc(1000 * sizeof(char*)); // Max path depth is small (10), 1000 is safe buffer
    char*** result_paths = NULL;
    int result_count = 0;
    int result_capacity = 0;

    // Start collecting paths from children of the dummy root, at depth 1
    for (int i = 0; i < root->num_children; ++i) {
        dfs_collect_paths(root->children[i].node, current_path_segments, 1,
                          &result_paths, &result_count, &result_capacity);
    }
    free(current_path_segments);

    // Prepare returnColumnSizes array for LeetCode's output format
    *returnSize = result_count;
    *returnColumnSizes = (int*)malloc(result_count * sizeof(int));
    for (int i = 0; i < result_count; ++i) {
        int len = 0;
        while (result_paths[i][len] != NULL) {
            len++;
        }
        (*returnColumnSizes)[i] = len;
    }

    // Cleanup: Free uthash table entries
    struct HashCountEntry *current_entry, *tmp_entry;
    HASH_ITER(hh, subtree_hash_counts, current_entry, tmp_entry) {
        HASH_DEL(subtree_hash_counts, current_entry);
        free(current_entry);
    }

    // Cleanup: Free the entire trie structure
    freeTrie(root);

    return result_paths;
}