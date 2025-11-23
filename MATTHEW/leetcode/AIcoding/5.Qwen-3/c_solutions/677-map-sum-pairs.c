#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[26];
    int value;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; ++i) {
        node->children[i] = NULL;
    }
    node->value = 0;
    return node;
}

typedef struct {
    TrieNode* root;
} MapSum;

MapSum* mapSumCreate() {
    MapSum* obj = (MapSum*)malloc(sizeof(MapSum));
    obj->root = createNode();
    return obj;
}

void mapSumInsert(MapSum* obj, char* key, int val) {
    TrieNode* node = obj->root;
    for (int i = 0; key[i]; ++i) {
        int index = key[i] - 'a';
        if (!node->children[index]) {
            node->children[index] = createNode();
        }
        node = node->children[index];
    }
    node->value = val;
}

int mapSumSum(MapSum* obj, char* prefix) {
    TrieNode* node = obj->root;
    for (int i = 0; prefix[i]; ++i) {
        int index = prefix[i] - 'a';
        if (!node->children[index]) {
            return 0;
        }
        node = node->children[index];
    }

    int sum = 0;
    void dfs(TrieNode* node) {
        if (!node) return;
        sum += node->value;
        for (int i = 0; i < 26; ++i) {
            dfs(node->children[i]);
        }
    }
    dfs(node);
    return sum;
}

void mapSumFree(MapSum* obj) {
    void freeNode(TrieNode* node) {
        if (!node) return;
        for (int i = 0; i < 26; ++i) {
            freeNode(node->children[i]);
        }
        free(node);
    }
    freeNode(obj->root);
    free(obj);
}