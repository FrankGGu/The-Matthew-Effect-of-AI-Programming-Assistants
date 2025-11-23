#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[26];
    int isEnd;
} TrieNode;

typedef struct {
    TrieNode* root;
} WordDictionary;

TrieNode* createTrieNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; ++i) {
        node->children[i] = NULL;
    }
    node->isEnd = 0;
    return node;
}

WordDictionary* wordDictionaryCreate() {
    WordDictionary* obj = (WordDictionary*)malloc(sizeof(WordDictionary));
    obj->root = createTrieNode();
    return obj;
}

void wordDictionaryAddWord(WordDictionary* obj, char* word) {
    TrieNode* node = obj->root;
    for (int i = 0; i < strlen(word); ++i) {
        int index = word[i] - 'a';
        if (!node->children[index]) {
            node->children[index] = createTrieNode();
        }
        node = node->children[index];
    }
    node->isEnd = 1;
}

int dfs(TrieNode* node, char* word, int index) {
    if (!node) return 0;
    if (index == strlen(word)) {
        return node->isEnd;
    }
    if (word[index] == '.') {
        for (int i = 0; i < 26; ++i) {
            if (dfs(node->children[i], word, index + 1)) {
                return 1;
            }
        }
        return 0;
    } else {
        int indexChar = word[index] - 'a';
        return dfs(node->children[indexChar], word, index + 1);
    }
}

int wordDictionarySearch(WordDictionary* obj, char* word) {
    return dfs(obj->root, word, 0);
}

void trieFree(TrieNode* node) {
    if (!node) return;
    for (int i = 0; i < 26; ++i) {
        trieFree(node->children[i]);
    }
    free(node);
}

void wordDictionaryFree(WordDictionary* obj) {
    trieFree(obj->root);
    free(obj);
}