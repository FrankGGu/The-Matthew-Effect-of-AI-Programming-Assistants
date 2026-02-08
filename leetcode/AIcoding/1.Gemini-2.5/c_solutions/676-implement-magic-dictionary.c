#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct TrieNode {
    struct TrieNode *children[26];
    bool isEndOfWord;
} TrieNode;

typedef struct {
    TrieNode *root;
} MagicDictionary;

TrieNode* createTrieNode() {
    TrieNode* newNode = (TrieNode*)malloc(sizeof(TrieNode));
    if (newNode) {
        for (int i = 0; i < 26; i++) {
            newNode->children[i] = NULL;
        }
        newNode->isEndOfWord = false;
    }
    return newNode;
}

void trieInsert(TrieNode* root, const char* word) {
    TrieNode* current = root;
    int len = strlen(word);
    for (int i = 0; i < len; i++) {
        int index = word[i] - 'a';
        if (!current->children[index]) {
            current->children[index] = createTrieNode();
        }
        current = current->children[index];
    }
    current->isEndOfWord = true;
}

bool trieSearchExact(TrieNode* root, const char* word) {
    TrieNode* current = root;
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

MagicDictionary* magicDictionaryCreate() {
    MagicDictionary* obj = (MagicDictionary*)malloc(sizeof(MagicDictionary));
    if (obj) {
        obj->root = createTrieNode();
    }
    return obj;
}

void magicDictionaryBuildDict(MagicDictionary* obj, char **dictionary, int dictionarySize) {
    if (!obj || !obj->root) return;

    for (int i = 0; i < dictionarySize; i++) {
        trieInsert(obj->root, dictionary[i]);
    }
}

bool magicDictionarySearch(MagicDictionary* obj, char* searchWord) {
    if (!obj || !obj->root || !searchWord) return false;

    int len = strlen(searchWord);
    char originalChar;

    for (int i = 0; i < len; i++) {
        originalChar = searchWord[i]; 

        for (char c = 'a'; c <= 'z'; c++) {
            if (c == originalChar) { 
                continue;
            }

            searchWord[i] = c; 
            if (trieSearchExact(obj->root, searchWord)) {
                searchWord[i] = originalChar; 
                return true;
            }
        }
        searchWord[i] = originalChar; 
    }

    return false;
}

void freeTrieNodes(TrieNode* node) {
    if (!node) return;
    for (int i = 0; i < 26; i++) {
        if (node->children[i]) {
            freeTrieNodes(node->children[i]);
        }
    }
    free(node);
}

void magicDictionaryFree(MagicDictionary* obj) {
    if (obj) {
        freeTrieNodes(obj->root);
        free(obj);
    }
}