#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TrieNode {
    struct TrieNode *children[26];
    int count;
};

struct TrieNode* createNode() {
    struct TrieNode* node = (struct TrieNode*)malloc(sizeof(struct TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->count = 0;
    return node;
}

void insert(struct TrieNode* root, const char* word) {
    struct TrieNode* node = root;
    for (int i = 0; word[i]; i++) {
        int index = word[i] - 'a';
        if (!node->children[index]) {
            node->children[index] = createNode();
        }
        node = node->children[index];
        node->count++;
    }
}

void search(struct TrieNode* root, const char* prefix, char** result, int* returnSize) {
    struct TrieNode* node = root;
    for (int i = 0; prefix[i]; i++) {
        int index = prefix[i] - 'a';
        if (!node->children[index]) {
            return;
        }
        node = node->children[index];
    }

    char buffer[100];
    int len = strlen(prefix);
    strcpy(buffer, prefix);
    buffer[len] = '\0';

    *returnSize = 0;
    dfs(node, buffer, len, result, returnSize);
}

void dfs(struct TrieNode* node, char* buffer, int depth, char** result, int* returnSize) {
    if (*returnSize >= 3) {
        return;
    }
    if (node->count > 0) {
        result[*returnSize] = strdup(buffer);
        (*returnSize)++;
    }
    for (int i = 0; i < 26; i++) {
        if (node->children[i]) {
            buffer[depth] = 'a' + i;
            buffer[depth + 1] = '\0';
            dfs(node->children[i], buffer, depth + 1, result, returnSize);
        }
    }
}

char*** suggestedProducts(char** products, int productsSize, char* searchWord, int* returnSize) {
    struct TrieNode* root = createNode();
    for (int i = 0; i < productsSize; i++) {
        insert(root, products[i]);
    }

    char*** result = (char***)malloc(strlen(searchWord) * sizeof(char**));
    char buffer[100];

    *returnSize = strlen(searchWord);
    for (int i = 0; i < *returnSize; i++) {
        buffer[i] = searchWord[i];
        buffer[i + 1] = '\0';
        result[i] = (char**)malloc(3 * sizeof(char*));
        int size = 0;
        search(root, buffer, result[i], &size);
        for (int j = size; j < 3; j++) {
            result[i][j] = NULL;
        }
    }

    return result;
}