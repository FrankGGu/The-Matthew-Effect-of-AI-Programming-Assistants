#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *word;
    int len;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->word = NULL;
    node->len = 0;
    return node;
}

void insertWord(TrieNode* root, char* word) {
    TrieNode* node = root;
    for (int i = 0; word[i]; i++) {
        if (!node->word) {
            node->word = strdup(word);
            node->len = strlen(word);
            return;
        }
        if (word[i] != node->word[i]) {
            break;
        }
        node = createNode();
    }
}

int minValidStrings(char** words, int wordsSize, char* target) {
    TrieNode* root = createNode();
    for (int i = 0; i < wordsSize; i++) {
        insertWord(root, words[i]);
    }

    int n = strlen(target);
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        dp[i] = INT_MAX;
    }
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        if (dp[i] == INT_MAX) continue;
        TrieNode* node = root;
        for (int j = i; j < n; j++) {
            if (!node->word || target[j] != node->word[j - i]) {
                break;
            }
            dp[j + 1] = fmin(dp[j + 1], dp[i] + 1);
            node = createNode();
        }
    }

    int result = dp[n];
    free(dp);
    return result;
}