#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[26];
    int isEndOfWord;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->isEndOfWord = 0;
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    return node;
}

typedef struct {
    TrieNode* root;
} Trie;

Trie* trieCreate() {
    Trie* obj = (Trie*)malloc(sizeof(Trie));
    obj->root = createNode();
    return obj;
}

void trieInsert(Trie* obj, char* word) {
    TrieNode* node = obj->root;
    for (int i = 0; word[i]; i++) {
        int index = word[i] - 'a';
        if (!node->children[index]) {
            node->children[index] = createNode();
        }
        node = node->children[index];
    }
    node->isEndOfWord = 1;
}

bool trieSearch(Trie* obj, char* word) {
    TrieNode* node = obj->root;
    for (int i = 0; word[i]; i++) {
        int index = word[i] - 'a';
        if (!node->children[index]) {
            return false;
        }
        node = node->children[index];
    }
    return node->isEndOfWord;
}

bool trieStartsWith(Trie* obj, char* prefix) {
    TrieNode* node = obj->root;
    for (int i = 0; prefix[i]; i++) {
        int index = prefix[i] - 'a';
        if (!node->children[index]) {
            return false;
        }
        node = node->children[index];
    }
    return true;
}

void trieFree(Trie* obj) {
    for (int i = 0; i < 26; i++) {
        if (obj->root->children[i]) {
            free(obj->root->children[i]);
        }
    }
    free(obj->root);
    free(obj);
}