#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** suggestions;
    int size;
} Result;

typedef struct TrieNode {
    struct TrieNode* children[26];
    int isEnd;
    char* word;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->isEnd = 0;
    node->word = NULL;
    return node;
}

void insertWord(TrieNode* root, char* word) {
    TrieNode* node = root;
    for (int i = 0; word[i]; i++) {
        int index = word[i] - 'a';
        if (!node->children[index]) {
            node->children[index] = createNode();
        }
        node = node->children[index];
    }
    node->isEnd = 1;
    node->word = strdup(word);
}

void collectSuggestions(TrieNode* node, char* prefix, char*** result, int* count) {
    if (*count >= 3 || !node) return;
    if (node->isEnd) {
        (*result)[*count] = strdup(node->word);
        (*count)++;
    }
    for (int i = 0; i < 26; i++) {
        collectSuggestions(node->children[i], prefix, result, count);
    }
}

char** searchSuggestion(TrieNode* root, char* prefix, int* returnSize) {
    TrieNode* node = root;
    for (int i = 0; prefix[i]; i++) {
        int index = prefix[i] - 'a';
        if (!node->children[index]) {
            *returnSize = 0;
            return NULL;
        }
        node = node->children[index];
    }
    char** result = (char**)malloc(3 * sizeof(char*));
    int count = 0;
    collectSuggestions(node, prefix, &result, &count);
    *returnSize = count;
    return result;
}

char*** suggestedProducts(char** products, int productsSize, char* searchWord, int* returnSize, int** returnColumnSizes) {
    TrieNode* root = createNode();
    for (int i = 0; i < productsSize; i++) {
        insertWord(root, products[i]);
    }
    int total = 0;
    char*** result = (char***)malloc(strlen(searchWord) * sizeof(char**));
    *returnColumnSizes = (int*)malloc(strlen(searchWord) * sizeof(int));
    for (int i = 0; i < strlen(searchWord); i++) {
        char prefix[100];
        strncpy(prefix, searchWord, i + 1);
        prefix[i + 1] = '\0';
        int size;
        char** suggestions = searchSuggestion(root, prefix, &size);
        result[i] = suggestions;
        (*returnColumnSizes)[i] = size;
        total += size;
    }
    *returnSize = strlen(searchWord);
    return result;
}