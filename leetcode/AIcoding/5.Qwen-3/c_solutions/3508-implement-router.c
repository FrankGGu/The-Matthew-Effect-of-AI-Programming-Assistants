#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[256];
    char* value;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 256; ++i) {
        node->children[i] = NULL;
    }
    node->value = NULL;
    return node;
}

void insert(TrieNode* root, const char* path, const char* value) {
    TrieNode* node = root;
    for (int i = 0; path[i] != '\0'; ++i) {
        char c = path[i];
        if (!node->children[c]) {
            node->children[c] = createNode();
        }
        node = node->children[c];
    }
    node->value = strdup(value);
}

char* search(TrieNode* root, const char* path) {
    TrieNode* node = root;
    for (int i = 0; path[i] != '\0'; ++i) {
        char c = path[i];
        if (!node->children[c]) {
            return NULL;
        }
        node = node->children[c];
    }
    return node->value;
}

void freeTrie(TrieNode* root) {
    if (!root) return;
    for (int i = 0; i < 256; ++i) {
        freeTrie(root->children[i]);
    }
    free(root->value);
    free(root);
}

char* routerGet(char* path) {
    static TrieNode* root = NULL;
    if (!root) {
        root = createNode();
    }
    return search(root, path);
}

void routerPut(char* path, char* value) {
    static TrieNode* root = NULL;
    if (!root) {
        root = createNode();
    }
    insert(root, path, value);
}