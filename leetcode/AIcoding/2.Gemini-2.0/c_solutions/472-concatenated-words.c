#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    bool isWord;
    struct TrieNode* children[26];
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->isWord = false;
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    return node;
}

void insert(TrieNode* root, char* word) {
    TrieNode* curr = root;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (curr->children[index] == NULL) {
            curr->children[index] = createNode();
        }
        curr = curr->children[index];
    }
    curr->isWord = true;
}

bool canForm(char* word, TrieNode* root, int start, int len, int* dp) {
    if (start == len) {
        return true;
    }

    if (dp[start] != -1) {
        return dp[start];
    }

    TrieNode* curr = root;
    for (int i = start; i < len; i++) {
        int index = word[i] - 'a';
        if (curr->children[index] == NULL) {
            dp[start] = false;
            return false;
        }
        curr = curr->children[index];
        if (curr->isWord) {
            if (canForm(word, root, i + 1, len, dp)) {
                dp[start] = true;
                return true;
            }
        }
    }

    dp[start] = false;
    return false;
}

char** findAllConcatenatedWordsInADict(char** words, int wordsSize, int* returnSize) {
    TrieNode* root = createNode();
    for (int i = 0; i < wordsSize; i++) {
        insert(root, words[i]);
    }

    char** result = (char**)malloc(wordsSize * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        int* dp = (int*)malloc(len * sizeof(int));
        for (int j = 0; j < len; j++) {
            dp[j] = -1;
        }
        if (canForm(words[i], root, 0, len, dp)) {
            result[*returnSize] = (char*)malloc((len + 1) * sizeof(char));
            strcpy(result[*returnSize], words[i]);
            (*returnSize)++;
        }
        free(dp);
    }

    return result;
}