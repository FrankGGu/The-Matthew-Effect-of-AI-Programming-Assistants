#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ALPHABET_SIZE 26

typedef struct TrieNode {
    struct TrieNode *children[ALPHABET_SIZE];
    bool isEndOfWord;
} TrieNode;

TrieNode* createNode() {
    TrieNode* newNode = (TrieNode*) malloc(sizeof(TrieNode));
    newNode->isEndOfWord = false;
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        newNode->children[i] = NULL;
    }
    return newNode;
}

typedef struct {
    TrieNode* root;
} WordDictionary;

WordDictionary* wordDictionaryCreate() {
    WordDictionary* obj = (WordDictionary*) malloc(sizeof(WordDictionary));
    obj->root = createNode();
    return obj;
}

void wordDictionaryAddWord(WordDictionary* obj, char * word) {
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

bool searchHelper(TrieNode* node, char* word) {
    if (!node) return false;
    if (*word == '\0') return node->isEndOfWord;

    if (*word == '.') {
        for (int i = 0; i < ALPHABET_SIZE; i++) {
            if (searchHelper(node->children[i], word + 1)) {
                return true;
            }
        }
        return false;
    } else {
        int index = *word - 'a';
        if (!node->children[index]) return false;
        return searchHelper(node->children[index], word + 1);
    }
}

bool wordDictionarySearch(WordDictionary* obj, char * word) {
    return searchHelper(obj->root, word);
}

void wordDictionaryFree(WordDictionary* obj) {
    // Implement a recursive free function to avoid memory leaks
    void freeTrie(TrieNode* node) {
        if (!node) return;
        for (int i = 0; i < ALPHABET_SIZE; i++) {
            freeTrie(node->children[i]);
        }
        free(node);
    }

    freeTrie(obj->root);
    free(obj);
}