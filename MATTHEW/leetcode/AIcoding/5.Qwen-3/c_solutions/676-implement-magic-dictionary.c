#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[26];
    int isEnd;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; ++i) {
        node->children[i] = NULL;
    }
    node->isEnd = 0;
    return node;
}

void insert(TrieNode* root, char* word) {
    TrieNode* node = root;
    for (int i = 0; i < strlen(word); ++i) {
        int index = word[i] - 'a';
        if (!node->children[index]) {
            node->children[index] = createNode();
        }
        node = node->children[index];
    }
    node->isEnd = 1;
}

int search(TrieNode* root, char* word) {
    TrieNode* node = root;
    for (int i = 0; i < strlen(word); ++i) {
        int index = word[i] - 'a';
        if (!node->children[index]) {
            return 0;
        }
        node = node->children[index];
    }
    return node->isEnd;
}

int hasOneDiff(TrieNode* root, char* word) {
    for (int i = 0; i < strlen(word); ++i) {
        char original = word[i];
        for (int c = 0; c < 26; ++c) {
            if (c == original - 'a') continue;
            word[i] = 'a' + c;
            if (search(root, word)) {
                return 1;
            }
        }
        word[i] = original;
    }
    return 0;
}

typedef struct {
    TrieNode* root;
} MagicDictionary;

MagicDictionary* magicDictionaryCreate() {
    MagicDictionary* obj = (MagicDictionary*)malloc(sizeof(MagicDictionary));
    obj->root = createNode();
    return obj;
}

void magicDictionaryBuildDict(MagicDictionary* obj, char** dict, int dictSize) {
    for (int i = 0; i < dictSize; ++i) {
        insert(obj->root, dict[i]);
    }
}

bool magicDictionarySearch(MagicDictionary* obj, char* word) {
    return hasOneDiff(obj->root, word);
}

void magicDictionaryFree(MagicDictionary* obj) {
    // Freeing the trie is not required for LeetCode submission
    free(obj);
}