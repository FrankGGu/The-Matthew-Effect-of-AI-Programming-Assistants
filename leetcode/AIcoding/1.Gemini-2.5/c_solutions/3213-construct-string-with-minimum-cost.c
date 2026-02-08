#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[26];
    long long min_cost_for_word;
} TrieNode;

TrieNode* createTrieNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->min_cost_for_word = -1;
    return node;
}

void insertWord(TrieNode* root, char* word, int cost) {
    TrieNode* curr = root;
    for (int i = 0; word[i] != '\0'; i++) {
        int idx = word[i] - 'a';
        if (curr->children[idx] == NULL) {
            curr->children[idx] = createTrieNode();
        }
        curr = curr->children[idx];
    }
    if (curr->min_cost_for_word == -1 || (long long)cost < curr->min_cost_for_word) {
        curr->min_cost_for_word = cost;
    }
}

void freeTrie(TrieNode* node) {
    if (!node) return;
    for (int i = 0; i < 26; i++) {
        freeTrie(node->children[i]);
    }
    free(node);
}

long long minimumCost(char* target, char** words, int wordsSize, int* costs) {
    int n = strlen(target);

    TrieNode* root = createTrieNode();
    for (int i = 0; i < wordsSize; i++) {
        insertWord(root, words[i], costs[i]);
    }

    long long* dp = (long long*)malloc(sizeof(long long) * (n + 1));

    dp[0] = 0;
    for (int i = 1; i <= n; i++) {
        dp[i] = -1;
    }

    for (int i = 0; i < n; i++) {
        if (dp[i] == -1) {
            continue;
        }

        TrieNode* curr = root;
        for (int j = i; j < n; j++) {
            int char_idx = target[j] - 'a';
            if (curr->children[char_idx] == NULL) {
                break;
            }
            curr = curr->children[char_idx];

            if (curr->min_cost_for_word != -1) {
                long long current_word_cost = curr->min_cost_for_word;
                long long cost_to_reach_j_plus_1 = dp[i] + current_word_cost;

                if (dp[j+1] == -1 || cost_to_reach_j_plus_1 < dp[j+1]) {
                    dp[j+1] = cost_to_reach_j_plus_1;
                }
            }
        }
    }

    long long result = dp[n];

    free(dp);
    freeTrie(root);

    return result;
}