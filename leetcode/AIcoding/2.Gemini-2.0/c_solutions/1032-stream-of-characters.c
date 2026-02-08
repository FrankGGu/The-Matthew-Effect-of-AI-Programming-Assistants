#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    bool isWord;
    struct TrieNode* children[26];
} TrieNode;

TrieNode* trieCreate() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->isWord = false;
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    return node;
}

void trieInsert(TrieNode* root, char* word) {
    int len = strlen(word);
    TrieNode* curr = root;
    for (int i = len - 1; i >= 0; i--) {
        int index = word[i] - 'a';
        if (curr->children[index] == NULL) {
            curr->children[index] = trieCreate();
        }
        curr = curr->children[index];
    }
    curr->isWord = true;
}

bool trieSearch(TrieNode* root, char* word) {
    int len = strlen(word);
    TrieNode* curr = root;
    for (int i = len - 1; i >= 0; i--) {
        int index = word[i] - 'a';
        if (curr->children[index] == NULL) {
            return false;
        }
        curr = curr->children[index];
        if (curr->isWord) {
            return true;
        }
    }
    return curr->isWord;
}

void trieFree(TrieNode* root) {
    if (root == NULL) return;
    for (int i = 0; i < 26; i++) {
        trieFree(root->children[i]);
    }
    free(root);
}

typedef struct {
    TrieNode* root;
    char stream[20001];
    int streamIndex;
} StreamChecker;

StreamChecker* streamCheckerCreate(char ** words, int wordsSize) {
    StreamChecker* obj = (StreamChecker*)malloc(sizeof(StreamChecker));
    obj->root = trieCreate();
    obj->streamIndex = 0;
    for (int i = 0; i < wordsSize; i++) {
        trieInsert(obj->root, words[i]);
    }
    return obj;
}

bool streamCheckerQuery(StreamChecker* obj, char letter) {
    obj->stream[obj->streamIndex++] = letter;
    obj->stream[obj->streamIndex] = '\0';
    return trieSearch(obj->root, obj->stream);
}

void streamCheckerFree(StreamChecker* obj) {
    trieFree(obj->root);
    free(obj);
}