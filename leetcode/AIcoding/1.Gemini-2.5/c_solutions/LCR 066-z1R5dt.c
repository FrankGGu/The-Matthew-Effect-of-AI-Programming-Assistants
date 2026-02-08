#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[26];
    int val_at_this_node;
    int prefix_sum;
} TrieNode;

TrieNode* createTrieNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    if (node) {
        for (int i = 0; i < 26; ++i) {
            node->children[i] = NULL;
        }
        node->val_at_this_node = 0;
        node->prefix_sum = 0;
    }
    return node;
}

typedef struct {
    TrieNode* root;
} MapSum;

MapSum* mapSumCreate() {
    MapSum* obj = (MapSum*)malloc(sizeof(MapSum));
    if (obj) {
        obj->root = createTrieNode();
    }
    return obj;
}

void mapSumInsert(MapSum* obj, char* key, int val) {
    int old_val = 0;
    TrieNode* curr_find = obj->root;
    int k_len = strlen(key);
    int found_key_path = 1;

    for (int i = 0; i < k_len; ++i) {
        int idx = key[i] - 'a';
        if (curr_find->children[idx] == NULL) {
            found_key_path = 0;
            break;
        }
        curr_find = curr_find->children[idx];
    }

    if (found_key_path) {
        old_val = curr_find->val_at_this_node;
    }

    int delta = val - old_val;

    TrieNode* curr_update = obj->root;
    for (int i = 0; i < k_len; ++i) {
        int idx = key[i] - 'a';
        if (curr_update->children[idx] == NULL) {
            curr_update->children[idx] = createTrieNode();
        }
        curr_update = curr_update->children[idx];
        curr_update->prefix_sum += delta;
    }
    curr_update->val_at_this_node = val;
}

int mapSumSum(MapSum* obj, char* prefix) {
    TrieNode* curr = obj->root;
    for (int i = 0; prefix[i] != '\0'; ++i) {
        int idx = prefix[i] - 'a';
        if (curr->children[idx] == NULL) {
            return 0;
        }
        curr = curr->children[idx];
    }
    return curr->prefix_sum;
}

void freeTrieNodes(TrieNode* node) {
    if (!node) return;
    for (int i = 0; i < 26; ++i) {
        freeTrieNodes(node->children[i]);
    }
    free(node);
}

void mapSumFree(MapSum* obj) {
    if (!obj) return;
    freeTrieNodes(obj->root);
    free(obj);
}