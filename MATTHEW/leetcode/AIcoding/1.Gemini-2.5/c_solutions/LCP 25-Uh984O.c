#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdio.h> // For debugging, remove for final submission if not needed

#define P1 31ULL
#define P2 131ULL
#define P3 1000000007ULL // A large prime modulus

#define MAX_PATH_DEPTH 10

typedef struct TreeNode {
    char* name;
    int id; // Path index that first created this node
    struct TreeNode** children; // Sorted by child name
    int num_children;
    int children_capacity;
    bool to_delete;
    unsigned long long subtree_hash_val; // Numerical hash
    bool hash_computed; // Flag to indicate if hash is computed
    struct TreeNode* next_global; // For linked list of all nodes
} TreeNode;

TreeNode* all_nodes_head = NULL;
int total_nodes_count = 0;

int compare_child_names(const void* a, const void* b) {
    TreeNode* node_a = *(TreeNode**)a;
    TreeNode* node_b = *(TreeNode**)b;
    return strcmp(node_a->name, node_b->name);
}

TreeNode* create_node(const char* name, int id) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->name = strdup(name);
    node->id = id;
    node->children = NULL;
    node->num_children = 0;
    node->children_capacity = 0;
    node->to_delete = false;
    node->subtree_hash_val = 0;
    node->hash_computed = false;

    // Add to global linked list
    node->next_global = all_nodes_head;
    all_nodes_head = node;
    total_nodes_count++;

    return node;
}

void add_child(TreeNode* parent, TreeNode* child) {
    if (parent->num_children == parent->children_capacity) {
        parent->children_capacity = parent->children_capacity == 0 ? 4 : parent->children_capacity * 2;
        parent->children = (TreeNode**)realloc(parent->children, sizeof(TreeNode*) * parent->children_capacity);
    }

    // Find insertion point to maintain sorted order
    int i = 0;
    while (i < parent->num_children && strcmp(child->name, parent->children[i]->name) > 0) {
        i++;
    }

    // Shift elements to make space
    if (i < parent->num_children) {
        memmove(&parent->children[i + 1], &parent->children[i], sizeof(TreeNode*) * (parent->num_children - i));
    }

    parent->children[i] = child;
    parent->num_children++;
}

TreeNode* find_child(TreeNode* parent, const char* name) {
    if (parent->num_children == 0) return NULL;

    int low = 0;
    int high = parent->num_children - 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        int cmp = strcmp(name, parent->children[mid]->name);
        if (cmp == 0) {
            return parent->children[mid];
        } else if (cmp < 0) {
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return NULL;
}

int compare_ull(const void* a, const void* b) {
    unsigned long long val_a = *(unsigned long long*)a;
    unsigned long long val_b = *(unsigned long long*)b;
    if (val_a < val_b) return -1;
    if (val_a > val_b) return 1;
    return 0;
}

unsigned long long compute_hash(TreeNode* node) {
    if (node->hash_computed) {
        return node->subtree_hash_val;
    }

    if (node->num_children == 0) {
        node->subtree_hash_val = 1; // Base hash for an empty folder
        node->hash_computed = true;
        return node->subtree_hash_val;
    }

    unsigned long long* child_hashes = (unsigned long long*)malloc(sizeof(unsigned long long) * node->num_children);
    for (int i = 0; i < node->num_children; ++i) {
        child_hashes[i] = compute_hash(node->children[i]);
    }

    qsort(child_hashes, node->num_children, sizeof(unsigned long long), compare_ull);

    unsigned long long current_hash = P1; // Start with a prime
    for (int i = 0; i < node->num_children; ++i) {
        current_hash = (current_hash * P2 + child_hashes[i]) % P3;
    }
    free(child_hashes);

    node->subtree_hash_val = current_hash;
    node->hash_computed = true;
    return node->subtree_hash_val;
}

int compare_nodes_for_grouping(const void* a, const void* b) {
    TreeNode* node_a = *(TreeNode**)a;
    TreeNode* node_b = *(TreeNode**)b;

    if (node_a->subtree_hash_val < node_b->subtree_hash_val) return -1;
    if (node_a->subtree_hash_val > node_b->subtree_hash_val) return 1;

    // If hashes are equal, sort by id to determine which to keep
    if (node_a->id < node_b->id) return -1;
    if (node_a->id > node_b->id) return 1;
    return 0;
}

char** result_paths = NULL;
int result_count = 0;
int result_capacity = 0;

void add_path_to_result(char* path_str) {
    if (result_count == result_capacity) {
        result_capacity = result_capacity == 0 ? 16 : result_capacity * 2;
        result_paths = (char**)realloc(result_paths, sizeof(char*) * result_capacity);
    }
    result_paths[result_count++] = path_str;
}

void collect_paths_dfs(TreeNode* node, char** current_path_segments, int depth) {
    if (node->to_delete) {
        return;
    }

    if (node->id != -1) { // Skip dummy root (id -1)
        current_path_segments[depth - 1] = node->name;

        // Construct full path string
        int total_len = 0;
        for (int i = 0; i < depth; ++i) {
            total_len += strlen(current_path_segments[i]);
            if (i < depth - 1) total_len++; // For '/' separator
        }

        char* path_str = (char*)malloc(total_len + 1);
        path_str[0] = '\0';
        for (int i = 0; i < depth; ++i) {
            strcat(path_str, current_path_segments[i]);
            if (i < depth - 1) strcat(path_str, "/");
        }
        add_path_to_result(path_str);
    }

    for (int i = 0; i < node->num_children; ++i) {
        collect_paths_dfs(node->children[i], current_path_segments, depth + 1);
    }
}

void free_tree(TreeNode* node) {
    if (!node) return;
    for (int i = 0; i < node->num_children; ++i) {
        free_tree(node->children[i]);
    }
    free(node->name);
    free(node->children);
    free(node);
}

char*** deleteDuplicateFolders(char*** paths, int pathsSize, int* pathsColSize, int* returnSize) {
    // Reset global state for LeetCode multiple test cases
    if (all_nodes_head) {
        // Free the entire tree structure from the root of the previous run
        // The `all_nodes_head` points to the last created node, not the root.
        // We need to free the root of the previous tree.
        // A simpler way for LeetCode is to free all nodes from the `all_nodes_head` linked list.
        TreeNode* current = all_nodes_head;
        while (current != NULL) {
            TreeNode* next = current->next_global;
            free(current->name);
            free(current->children);
            free(current);
            current = next;
        }
    }
    all_nodes_head = NULL;
    total_nodes_count = 0;

    if (result_paths) {
        for (int i = 0; i < result_count; ++i) {
            free(result_paths[i]);
        }
        free(result_paths);
    }
    result_paths = NULL;
    result_count = 0;
    result_capacity = 0;

    // 1. Build Trie and Assign IDs
    // The id of a folder is the index of the path that first created it.
    TreeNode* root = create_node("", -1); // Dummy root node with id -1

    for (int i = 0; i < pathsSize; ++i) {
        TreeNode* current = root;
        for (int j = 0; j < pathsColSize[i]; ++j) {
            char* folder_name = paths[i][j];
            TreeNode* found_child = find_child(current, folder_name);

            if (found_child == NULL) {
                TreeNode* new_node = create_node(folder_name, i); // Assign ID as path index
                add_child(current, new_node);
                current = new_node;
            } else {
                current = found_child;
                // Folder ID is set at its first creation and never updated.
            }
        }
    }

    // 2. Compute Subtree Hashes for all nodes
    // Iterate through the global linked list of all nodes and compute hash.
    // The `compute_hash` function handles memoization (`hash_computed` flag).
    TreeNode* temp_node = all_nodes_head;
    while(temp_node != NULL) {
        compute_hash(temp_node);
        temp_node = temp_node->next_global;
    }

    // 3. Group Nodes by Hash and Mark for Deletion
    // Create a flat array of all nodes (excluding the dummy root)
    TreeNode** all_nodes_arr = NULL;
    int actual_nodes_in_arr = 0;
    if (total_nodes_count > 1) { // If there are nodes other than the dummy root
        all_nodes_arr = (TreeNode**)malloc(sizeof(TreeNode*) * (total_nodes_count - 1));
        temp_node = all_nodes_head;
        while (temp_node != NULL) {
            if (temp_node != root) { // Exclude dummy root from processing
                all_nodes_arr[actual_nodes_in_arr++] = temp_node;
            }
            temp_node = temp_node->next_global;
        }
    }

    if (actual_nodes_in_arr > 0) {
        // Sort nodes by subtree hash, then by id (for tie-breaking)
        qsort(all_nodes_arr, actual_nodes_in_arr, sizeof(TreeNode*), compare_nodes_for_grouping);

        for (int i = 0; i < actual_nodes_in_arr; ) {
            int j = i;
            // Find all consecutive nodes with the same hash
            while (j < actual_nodes_in_arr && all_nodes_arr[j]->subtree_hash_val == all_nodes_arr[i]->subtree_hash_val) {
                j++;
            }

            // If there are duplicates (more than one node with this hash)
            if (j - i > 1) {
                // Due to sorting, all_nodes_arr[i] is the node with the smallest id among duplicates.
                // Mark all other nodes in this group for deletion.
                for (int k = i + 1; k < j; ++k) {
                    all_nodes_arr[k]->to_delete = true;
                }
            }
            i = j; // Move to the next group
        }
    }
    free(all_nodes_arr); // Free the temporary array of pointers

    // 4. Collect Remaining Paths (DFS)
    char** current_path_segments = (char**)malloc(sizeof(char*) * MAX_PATH_DEPTH);
    collect_paths_dfs(root, current_path_segments, 0); // Depth starts at 0 for the dummy root
    free(current_path_segments);

    // Set returnSize
    *returnSize = result_count;

    // Free the entire tree structure (all nodes)
    // The `free_tree` function will recursively free all allocated memory for nodes and their names/children arrays.
    // This also implicitly frees all nodes in the `all_nodes_head` linked list as they are part of the tree.
    free_tree(root);

    return result_paths;
}