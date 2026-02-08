#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define ALPHABET_SIZE 26

typedef struct TrieNode {
    struct TrieNode* children[ALPHABET_SIZE];
    bool isEndOfWord;
} TrieNode;

typedef struct {
    TrieNode* root;
} Trie;

TrieNode* createTrieNode() {
    TrieNode* newNode = (TrieNode*)malloc(sizeof(TrieNode));
    if (newNode) {
        newNode->isEndOfWord = false;
        for (int i = 0; i < ALPHABET_SIZE; i++) {
            newNode->children[i] = NULL;
        }
    }
    return newNode;
}

Trie* trieCreate() {
    Trie* obj = (Trie*)malloc(sizeof(Trie));
    if (obj) {
        obj->root = createTrieNode();
    }
    return obj;
}

void trieInsert(Trie* obj, char* word) {
    TrieNode* current = obj->root;
    int len = strlen(word);
    for (int i = 0; i < len; i++) {
        int index = word[i] - 'a';
        if (current->children[index] == NULL) {
            current->children[index] = createTrieNode();
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
        if (current->children[index] == NULL) {
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
        if (current->children[index] == NULL) {
            return false;
        }
        current = current->children[index];
    }
    return true;
}

void freeTrieNodes(TrieNode* node) {
    if (node == NULL) {
        return;
    }
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        freeTrieNodes(node->children[i]);
    }
    free(node);
}

void trieFree(Trie* obj) {
    if (obj == NULL) {
        return;
    }
    freeTrieNodes(obj->root);
    free(obj);
}