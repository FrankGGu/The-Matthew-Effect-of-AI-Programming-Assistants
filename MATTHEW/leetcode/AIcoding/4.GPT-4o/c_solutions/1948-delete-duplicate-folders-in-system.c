#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

struct TrieNode {
    struct TrieNode* children[26];
    int count;
    char* path;
};

struct TrieNode* createNode() {
    struct TrieNode* node = (struct TrieNode*)malloc(sizeof(struct TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->count = 0;
    node->path = NULL;
    return node;
}

void insert(struct TrieNode* root, char* path) {
    struct TrieNode* current = root;
    char* token = strtok(path, "/");
    while (token != NULL) {
        int index = token[0] - 'a';
        if (current->children[index] == NULL) {
            current->children[index] = createNode();
        }
        current = current->children[index];
        token = strtok(NULL, "/");
    }
    current->count++;
    current->path = path;
}

void collectPaths(struct TrieNode* node, char*** result, int* returnSize) {
    if (node == NULL) return;
    if (node->count > 1) {
        return;
    }
    if (node->path != NULL) {
        result[(*returnSize)++] = node->path;
    }
    for (int i = 0; i < 26; i++) {
        collectPaths(node->children[i], result, returnSize);
    }
}

char** deleteDuplicateFolder(char** paths, int pathsSize, int* returnSize) {
    struct TrieNode* root = createNode();
    for (int i = 0; i < pathsSize; i++) {
        char* path = strdup(paths[i]);
        insert(root, path);
    }
    char** result = (char**)malloc(pathsSize * sizeof(char*));
    *returnSize = 0;
    collectPaths(root, &result, returnSize);
    return result;
}