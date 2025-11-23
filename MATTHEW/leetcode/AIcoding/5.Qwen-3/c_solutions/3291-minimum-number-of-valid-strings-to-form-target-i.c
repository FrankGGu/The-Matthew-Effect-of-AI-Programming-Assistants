#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[26];
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    return node;
}

void insertWord(TrieNode* root, const char* word) {
    TrieNode* node = root;
    for (int i = 0; word[i]; i++) {
        int index = word[i] - 'a';
        if (!node->children[index]) {
            node->children[index] = createNode();
        }
        node = node->children[index];
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
        dp[i] = n + 1;
    }
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        if (dp[i] == n + 1) continue;
        TrieNode* node = root;
        for (int j = i; j < n; j++) {
            int index = target[j] - 'a';
            if (!node->children[index]) break;
            node = node->children[index];
            dp[j + 1] = fmin(dp[j + 1], dp[i] + 1);
        }
    }

    int result = dp[n];
    free(dp);
    return result;
}