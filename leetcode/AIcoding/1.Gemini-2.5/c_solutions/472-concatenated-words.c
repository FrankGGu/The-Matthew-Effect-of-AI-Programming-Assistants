#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <limits.h> // For INT_MAX

#define MAX_TRIE_NODES 3000005

struct TrieNode {
    short children[26]; // Stores index of child node, 0 for NULL
    bool is_end_of_word;
};

struct TrieNode trie_nodes[MAX_TRIE_NODES];
int next_node_idx; // Index for the next available node in trie_nodes

void initTrie() {
    next_node_idx = 1; // Node 0 can be considered NULL or unused, start from 1
    // No explicit initialization of all nodes needed, only as they are created
}

int createNode() {
    // Basic check for capacity, though MAX_TRIE_NODES should be sufficient
    if (next_node_idx >= MAX_TRIE_NODES) {
        exit(1); // Should not happen with given constraints
    }
    int new_idx = next_node_idx++;
    trie_nodes[new_idx].is_end_of_word = false;
    for (int i = 0; i < 26; i++) {
        trie_nodes[new_idx].children[i] = 0; // 0 indicates no child
    }
    return new_idx;
}

void insert(int root_idx, char* word) {
    int curr_idx = root_idx;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (trie_nodes[curr_idx].children[index] == 0) {
            trie_nodes[curr_idx].children[index] = createNode();
        }
        curr_idx = trie_nodes[curr_idx].children[index];
    }
    trie_nodes[curr_idx].is_end_of_word = true;
}

void remove_word_temp(int root_idx, char* word) {
    int curr_idx = root_idx;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (trie_nodes[curr_idx].children[index] == 0) {
            return; // Word not found, should not happen if it was inserted
        }
        curr_idx = trie_nodes[curr_idx].children[index];
    }
    if (curr_idx != 0) { // Ensure it's a valid node
        trie_nodes[curr_idx].is_end_of_word = false;
    }
}

void add_word_back_temp(int root_idx, char* word) {
    int curr_idx = root_idx;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (trie_nodes[curr_idx].children[index] == 0) {
            return; // Word not found, should not happen if it was inserted
        }
        curr_idx = trie_nodes[curr_idx].children[index];
    }
    if (curr_idx != 0) { // Ensure it's a valid node
        trie_nodes[curr_idx].is_end_of_word = true;
    }
}

int* memo_table;

int can_segment_count(int root_idx, char* s, int start_idx, int len) {
    if (start_idx == len) {
        return 0; // 0 words needed for an empty string
    }
    if (memo_table[start_idx] != -1) {
        return memo_table[start_idx];
    }

    int min_words = INT_MAX;
    int curr_trie_node_idx = root_idx;

    for (int i = start_idx; i < len; i++) {
        int index = s[i] - 'a';
        if (trie_nodes[curr_trie_node_idx].children[index] == 0) {
            break; // No word in trie has this prefix, so no further segments can be formed
        }
        curr_trie_node_idx = trie_nodes[curr_trie_node_idx].children[index];

        if (trie_nodes[curr_trie_node_idx].is_end_of_word) { // Found a valid word ending at `i`
            int res = can_segment_count(root_idx, s, i + 1, len);
            if (res != INT_MAX) { // If the rest of the string can be segmented
                if (1 + res < min_words) {
                    min_words = 1 + res;
                }
            }
        }
    }

    memo_table[start_idx] = min_words;
    return min_words;
}

char** concatenatedWords(char** words, int wordsSize, int* returnSize) {
    *returnSize = 0;
    if (wordsSize == 0) {
        return NULL;
    }

    initTrie(); // Initialize the global trie_nodes array and next_node_idx
    int trie_root_idx = createNode(); // The actual root node for the trie

    // Insert all non-empty words into the trie
    for (int i = 0; i < wordsSize; i++) {
        if (strlen(words[i]) > 0) {
            insert(trie_root_idx, words[i]);
        }
    }

    // Allocate space for the result array
    char** result = (char**)malloc(wordsSize * sizeof(char*));
    int result_idx = 0;

    // Iterate through each word to check if it's a concatenated word
    for (int i = 0; i < wordsSize; i++) {
        char* current_word = words[i];
        int current_word_len = strlen(current_word);

        if (current_word_len == 0) continue; // Empty strings cannot be concatenated words

        // Initialize memoization table for the current word
        memo_table = (int*)malloc((current_word_len + 1) * sizeof(int));
        for (int k = 0; k <= current_word_len; k++) {
            memo_table[k] = -1;
        }

        // Temporarily remove the current word from the trie
        // This ensures that a word cannot be formed by itself
        remove_word_temp(trie_root_idx, current_word);

        // Check if the current word can be segmented into at least two words
        int count = can_segment_count(trie_root_idx, current_word, 0, current_word_len);

        // Add the word back to the trie for subsequent checks
        add_word_back_temp(trie_root_idx, current_word);

        // If the word can be formed by 2 or more words, add it to the result
        if (count >= 2) {
            result[result_idx++] = current_word;
        }
        free(memo_table); // Free memo table for current word
    }

    *returnSize = result_idx;
    // Resize the result array to the actual number of concatenated words
    if (result_idx == 0) {
        free(result);
        return NULL;
    }
    result = (char**)realloc(result, result_idx * sizeof(char*));
    return result;
}