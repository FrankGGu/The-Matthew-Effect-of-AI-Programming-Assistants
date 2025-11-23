#include <stdlib.h>
#include <stdbool.h>

#define ALPHABET_SIZE 26

typedef struct TrieNode {
    struct TrieNode* children[ALPHABET_SIZE];
    bool isEndOfWord;
} TrieNode;

TrieNode* createTrieNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    if (node) {
        node->isEndOfWord = false;
        for (int i = 0; i < ALPHABET_SIZE; i++) {
            node->children[i] = NULL;
        }
    }
    return node;
}

typedef struct {
    TrieNode* root;
} WordDictionary;

WordDictionary* wordDictionaryCreate() {
    WordDictionary* obj = (WordDictionary*)malloc(sizeof(WordDictionary));
    if (obj) {
        obj->root = createTrieNode();
    }
    return obj;
}

void wordDictionaryAddWord(WordDictionary* obj, char * word) {
    TrieNode* current = obj->root;
    while (*word != '\0') {
        int index = *word - 'a';
        if (current->children[index] == NULL) {
            current->children[index] = createTrieNode();
        }
        current = current->children[index];
        word++;
    }
    current->isEndOfWord = true;
}

bool searchRecursive(TrieNode* node, char* word) {
    if (node == NULL) {
        return false;
    }

    if (*word == '\0') {
        return node->isEndOfWord;
    }

    char c = *word;
    if (c == '.') {
        for (int i = 0; i < ALPHABET_SIZE; i++) {
            if (searchRecursive(node->children[i], word + 1)) {
                return true;
            }
        }
        return false;
    } else {
        int index = c - 'a';
        return searchRecursive(node->children[index], word + 1);
    }
}

bool wordDictionarySearch(WordDictionary* obj, char * word) {
    return searchRecursive(obj->root, word);
}

void freeTrieNode(TrieNode* node) {
    if (node == NULL) {
        return;
    }
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        freeTrieNode(node->children[i]);
    }
    free(node);
}

void wordDictionaryFree(WordDictionary* obj) {
    if (obj == NULL) {
        return;
    }
    freeTrieNode(obj->root);
    free(obj);
}