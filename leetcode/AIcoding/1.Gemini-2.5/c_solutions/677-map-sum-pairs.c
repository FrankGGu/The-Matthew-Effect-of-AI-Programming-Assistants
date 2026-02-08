#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[26];
    int val;
    int prefix_sum;
} TrieNode;

typedef struct {
    TrieNode* root;
} MapSum;

TrieNode* createTrieNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    if (node == NULL) {
        return NULL;
    }
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->val = 0;
    node->prefix_sum = 0;
    return node;
}

MapSum* mapSumCreate() {
    MapSum* obj = (MapSum*)malloc(sizeof(MapSum));
    if (obj == NULL) {
        return NULL;
    }
    obj->root = createTrieNode();
    return obj;
}

void mapSumInsert(MapSum* obj, char* key, int val) {
    TrieNode* curr = obj->root;
    int old_val = 0;

    TrieNode* temp_curr = obj->root;
    for (int i = 0; key[i] != '\0'; i++) {
        int idx = key[i] - 'a';
        if (temp_curr->children[idx] == NULL) {
            temp_curr->children[idx] = createTrieNode();
        }
        temp_curr = temp_curr->children[idx];
    }
    old_val = temp_curr->val;

    int diff = val - old_val;

    curr = obj->root;
    for (int i = 0; key[i] != '\0'; i++) {
        int idx = key[i] - 'a';
        curr->prefix_sum += diff;
        curr = curr->children[idx];
    }
    curr->prefix_sum += diff;
    curr->val = val;
}

int mapSumSum(MapSum* obj, char* prefix) {
    TrieNode* curr = obj->root;
    for (int i = 0; prefix[i] != '\0'; i++) {
        int idx = prefix[i] - 'a';
        if (curr->children[idx] == NULL) {
            return 0;
        }
        curr = curr->children[idx];
    }
    return curr->prefix_sum;
}

void freeTrieNode(TrieNode* node) {
    if (node == NULL) {
        return;
    }
    for (int i = 0; i < 26; i++) {
        freeTrieNode(node->children[i]);
    }
    free(node);
}

void mapSumFree(MapSum* obj) {
    if (obj == NULL) {
        return;
    }
    freeTrieNode(obj->root);
    free(obj);
}