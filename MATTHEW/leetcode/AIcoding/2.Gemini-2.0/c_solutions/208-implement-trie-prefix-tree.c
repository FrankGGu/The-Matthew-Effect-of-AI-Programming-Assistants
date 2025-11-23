#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ALPHABET_SIZE 26

typedef struct TrieNode {
    struct TrieNode *children[ALPHABET_SIZE];
    bool isEndOfWord;
} TrieNode;

TrieNode* trieCreate() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        node->children[i] = NULL;
    }
    node->isEndOfWord = false;
    return node;
}

void trieInsert(TrieNode* obj, char * word) {
    TrieNode* current = obj;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (current->children[index] == NULL) {
            current->children[index] = trieCreate();
        }
        current = current->children[index];
    }
    current->isEndOfWord = true;
}

bool trieSearch(TrieNode* obj, char * word) {
    TrieNode* current = obj;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (current->children[index] == NULL) {
            return false;
        }
        current = current->children[index];
    }
    return current->isEndOfWord;
}

bool trieStartsWith(TrieNode* obj, char * prefix) {
    TrieNode* current = obj;
    for (int i = 0; prefix[i] != '\0'; i++) {
        int index = prefix[i] - 'a';
        if (current->children[index] == NULL) {
            return false;
        }
        current = current->children[index];
    }
    return true;
}

void trieFree(TrieNode* obj) {
    if (obj == NULL) return;
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        trieFree(obj->children[i]);
    }
    free(obj);
}