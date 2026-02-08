#include <stdlib.h>
#include <string.h>
#include <limits.h>

#define ALPHABET_SIZE 26

typedef struct TrieNode {
    struct TrieNode* children[ALPHABET_SIZE];
} TrieNode;

TrieNode* createTrieNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    if (node) {
        for (int i = 0; i < ALPHABET_SIZE; i++) {
            node->children[i] = NULL;
        }
    }
    return node;
}

void insert(TrieNode* root, char* word) {
    TrieNode* curr = root;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (!curr->children[index]) {
            curr->children[index] = createTrieNode();
        }
        curr = curr->children[index];
    }
}

void freeTrie(TrieNode* node) {
    if (!node) return;
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        if (node->children[i]) {
            freeTrie(node->children[i]);
        }
    }
    free(node);
}

int minimumValidStrings(char* target, char** words, int wordsSize) {
    int target_len = strlen(target);

    TrieNode* root = createTrieNode();
    if (!root) {
        return -1;
    }

    for (int i = 0; i < wordsSize; i++) {
        insert(root, words[i]);
    }

    // dp[i] will store the minimum number of valid strings to form target[0...i-1]
    int* dp = (int*)malloc((target_len + 1) * sizeof(int));
    if (!dp) {
        freeTrie(root);
        return -1;
    }

    // Initialize dp array with INT_MAX (representing infinity)
    for (int i = 0; i <= target_len; i++) {
        dp[i] = INT_MAX;
    }
    dp[0] = 0; // Base case: 0 strings to form an empty prefix

    // Iterate through the target string
    for (int i = 0; i < target_len; i++) {
        // If target[0...i-1] cannot be formed, we cannot extend from this point
        if (dp[i] == INT_MAX) {
            continue;
        }

        TrieNode* curr_node = root;
        // Try to form substrings target[i...j] starting from index i
        for (int j = i; j < target_len; j++) {
            int char_idx = target[j] - 'a';

            // If the current character is not in the Trie, then target[i...j]
            // cannot be a prefix of any word, nor can any longer substring starting with target[i...j].
            if (!curr_node->children[char_idx]) {
                break;
            }
            curr_node = curr_node->children[char_idx];

            // At this point, target[i...j] is a prefix of some word in 'words'.
            // So, target[i...j] is a valid string.
            // Update dp[j+1] (minimum strings to form target[0...j])
            if (dp[j + 1] > dp[i] + 1) {
                dp[j + 1] = dp[i] + 1;
            }
        }
    }

    int result = dp[target_len];
    free(dp);
    freeTrie(root); // Clean up Trie memory

    // If dp[target_len] is still INT_MAX, it means target cannot be formed
    return (result == INT_MAX) ? -1 : result;
}