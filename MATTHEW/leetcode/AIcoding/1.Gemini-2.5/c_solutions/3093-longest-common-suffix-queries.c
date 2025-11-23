#include <stdlib.h> // For malloc, free, strdup
#include <string.h> // For strlen
#include <limits.h> // For INT_MAX

#define MAX_TRIE_NODES 100005 

typedef struct TrieNode {
    struct TrieNode* children[26]; // Pointers to child nodes for 'a' through 'z'
    int min_len_idx;              // Stores the original index of the word from 'words'
                                  // that has the minimum length among all words whose
                                  // reversed form passes through this node.
    int min_len_val;              // Stores the original length of that word.
} TrieNode;

TrieNode trie_nodes[MAX_TRIE_NODES];
int node_count; // Counter for allocating nodes from the pool.

TrieNode* newNode() {
    TrieNode* node = &trie_nodes[node_count++];
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->min_len_idx = -1;     // Initialize to -1, indicating no word has passed through yet.
    node->min_len_val = INT_MAX; // Initialize to maximum integer value for length comparison.
    return node;
}

void reverse_string(char* s) {
    int len = strlen(s);
    for (int i = 0; i < len / 2; i++) {
        char temp = s[i];
        s[i] = s[len - 1 - i];
        s[len - 1 - i] = temp;
    }
}

void insert(TrieNode* root, char* reversed_s, int original_idx, int original_len) {
    TrieNode* curr = root;

    // Update the root node's min_len_val and min_len_idx.
    // This is crucial because any word passes through the root, and queries might
    // effectively match an "empty" suffix (i.e., just the root).
    if (original_len < curr->min_len_val) {
        curr->min_len_val = original_len;
        curr->min_len_idx = original_idx;
    }

    int len = strlen(reversed_s);
    for (int i = 0; i < len; i++) {
        int char_idx = reversed_s[i] - 'a';
        if (curr->children[char_idx] == NULL) {
            curr->children[char_idx] = newNode();
        }
        curr = curr->children[char_idx];

        // Update the current node's min_len_val and min_len_idx.
        // This ensures that every node along the path stores the index of the shortest
        // word (from the 'words' array) whose reversed form passes through this node.
        // This directly helps in finding the minimum length word for a given common suffix.
        if (original_len < curr->min_len_val) {
            curr->min_len_val = original_len;
            curr->min_len_idx = original_idx;
        }
    }
}

int search(TrieNode* root, char* reversed_query_s) {
    TrieNode* curr = root;
    int len = strlen(reversed_query_s);

    for (int i = 0; i < len; i++) {
        int char_idx = reversed_query_s[i] - 'a';
        if (curr->children[char_idx] == NULL) {
            // If a character in the reversed query word is not found,
            // it means no word in 'words' has this suffix.
            return -1;
        }
        curr = curr->children[char_idx];
    }
    // If we successfully traversed the entire reversed query word,
    // 'curr' now points to the node representing the longest common suffix.
    // The 'min_len_idx' at this node holds the desired result.
    return curr->min_len_idx;
}

int* longestCommonSuffixQueries(char** words, int wordsSize, char** query_words, int query_wordsSize, int* returnSize) {
    // Reset the global node_count for each test case.
    // This effectively clears the Trie for a new test case when using a global pool.
    node_count = 0; 
    TrieNode* root = newNode(); // Create the root of the Trie.

    // Store original lengths of words. We need these for comparison during insertion,
    // as the words themselves will be reversed or copied and reversed.
    int* original_lengths = (int*)malloc(wordsSize * sizeof(int));
    if (original_lengths == NULL) {
        *returnSize = 0;
        return NULL; // Handle malloc failure
    }
    for (int i = 0; i < wordsSize; i++) {
        original_lengths[i] = strlen(words[i]);
    }

    // Insert all words into the Trie after reversing them.
    for (int i = 0; i < wordsSize; i++) {
        // Create a mutable copy of the word to reverse it, as input strings might be read-only.
        char* reversed_word_copy = strdup(words[i]);
        if (reversed_word_copy == NULL) {
            free(original_lengths);
            *returnSize = 0;
            return NULL; // Handle strdup failure
        }
        reverse_string(reversed_word_copy);
        insert(root, reversed_word_copy, i, original_lengths[i]);
        free(reversed_word_copy); // Free the copy after insertion.
    }

    // Process all queries.
    int* results = (int*)malloc(query_wordsSize * sizeof(int));
    if (results == NULL) {
        free(original_lengths);
        *returnSize = 0;
        return NULL; // Handle malloc failure
    }
    *returnSize = query_wordsSize; // Set the return size for LeetCode's output.

    for (int i = 0; i < query_wordsSize; i++) {
        // Create a mutable copy of the query word to reverse it.
        char* reversed_query_copy = strdup(query_words[i]);
        if (reversed_query_copy == NULL) {
            free(original_lengths);
            free(results);
            *returnSize = 0;
            return NULL; // Handle strdup failure
        }
        reverse_string(reversed_query_copy);
        results[i] = search(root, reversed_query_copy);
        free(reversed_query_copy); // Free the copy after searching.
    }

    free(original_lengths); // Free the array used to store original lengths.

    return results; // Return the array of results.
}