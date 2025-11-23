#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *word;
    int len;
} WordInfo;

typedef struct TrieNode {
    struct TrieNode *children[26];
    int count;
} TrieNode;

TrieNode* createNode() {
    TrieNode *node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->count = 0;
    return node;
}

void insertWord(TrieNode *root, const char *word) {
    TrieNode *current = root;
    for (int i = strlen(word) - 1; i >= 0; i--) {
        int index = word[i] - 'a';
        if (!current->children[index]) {
            current->children[index] = createNode();
        }
        current = current->children[index];
        current->count++;
    }
}

int querySuffix(TrieNode *root, const char *word) {
    TrieNode *current = root;
    int count = 0;
    for (int i = strlen(word) - 1; i >= 0; i--) {
        int index = word[i] - 'a';
        if (!current->children[index]) {
            break;
        }
        current = current->children[index];
        count = current->count;
    }
    return count;
}

int* suffixQueries(char** words, int wordsSize, char** queries, int queriesSize, int* returnSize) {
    TrieNode *root = createNode();
    for (int i = 0; i < wordsSize; i++) {
        insertWord(root, words[i]);
    }

    int *result = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        result[i] = querySuffix(root, queries[i]);
    }

    *returnSize = queriesSize;
    return result;
}