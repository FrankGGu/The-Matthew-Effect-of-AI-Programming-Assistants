#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[26];
    int isEndOfWord;
} TrieNode;

typedef struct {
    TrieNode* root;
} Trie;

Trie* trieCreate() {
    Trie* obj = (Trie*)malloc(sizeof(Trie));
    obj->root = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        obj->root->children[i] = NULL;
    }
    obj->root->isEndOfWord = 0;
    return obj;
}

void trieInsert(Trie* obj, char* word) {
    TrieNode* node = obj->root;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (!node->children[index]) {
            node->children[index] = (TrieNode*)malloc(sizeof(TrieNode));
            for (int j = 0; j < 26; j++) {
                node->children[index]->children[j] = NULL;
            }
            node->children[index]->isEndOfWord = 0;
        }
        node = node->children[index];
    }
    node->isEndOfWord = 1;
}

bool trieSearch(Trie* obj, char* word) {
    TrieNode* node = obj->root;
    for (int i = 0; word[i] != '\0'; i++) {
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
    for (int i = 0; prefix[i] != '\0'; i++) {
        int index = prefix[i] - 'a';
        if (!node->children[index]) {
            return false;
        }
        node = node->children[index];
    }
    return true;
}

void trieFree(Trie* obj) {
    TrieNode* stack[1000];
    int top = 0;
    stack[top++] = obj->root;
    while (top > 0) {
        TrieNode* node = stack[--top];
        for (int i = 0; i < 26; i++) {
            if (node->children[i]) {
                stack[top++] = node->children[i];
            }
        }
        free(node);
    }
    free(obj);
}