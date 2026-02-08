#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#define ALPHABET_SIZE 26

typedef struct TrieNode {
    struct TrieNode* children[ALPHABET_SIZE];
    bool isEndOfWord;
} TrieNode;

typedef struct {
    TrieNode* root;
} Trie;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    if (node) {
        node->isEndOfWord = false;
        for (int i = 0; i < ALPHABET_SIZE; i++) {
            node->children[i] = NULL;
        }
    }
    return node;
}

Trie* trieCreate() {
    Trie* obj = (Trie*)malloc(sizeof(Trie));
    if (obj) {
        obj->root = createNode();
    }
    return obj;
}

void trieInsert(Trie* obj, char* word) {
    TrieNode* current = obj->root;
    int len = strlen(word);
    for (int i = 0; i < len; i++) {
        int index = word[i] - 'a';
        if (!current->children[index]) {
            current->children[index] = createNode();
        }
        current = current->children[index];
    }
    current->isEndOfWord = true;
}

bool trieSearch(Trie* obj, char* word) {
    TrieNode* current = obj->root;
    int len = strlen(word);
    for (int i = 0; i < len; i++) {
        int index = word[i] - 'a';
        if (!current->children[index]) {
            return false;
        }
        current = current->children[index];
    }
    return current != NULL && current->isEndOfWord;
}

bool trieStartsWith(Trie* obj, char* prefix) {
    TrieNode* current = obj->root;
    int len = strlen(prefix);
    for (int i = 0; i < len; i++) {
        int index = prefix[i] - 'a';
        if (!current->children[index]) {
            return false;
        }
        current = current->children[index];
    }
    return true;
}

void freeTrieNode(TrieNode* node) {
    if (!node) {
        return;
    }
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        if (node->children[i]) {
            freeTrieNode(node->children[i]);
        }
    }
    free(node);
}

void trieFree(Trie* obj) {
    if (obj) {
        freeTrieNode(obj->root);
        free(obj);
    }
}