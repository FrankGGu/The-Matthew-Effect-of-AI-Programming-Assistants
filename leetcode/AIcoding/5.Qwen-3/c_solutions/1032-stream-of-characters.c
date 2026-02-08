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
    for (int i = 0; word[i]; ++i) {
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
    for (int i = 0; word[i]; ++i) {
        int index = word[i] - 'a';
        if (!node->children[index]) {
            return 0;
        }
        node = node->children[index];
        if (node->isEnd) {
            return 1;
        }
    }
    return 0;
}

typedef struct {
    TrieNode* root;
    char* buffer;
    int bufferLen;
} StreamChecker;

StreamChecker* streamCheckerCreate(char** words, int wordsSize) {
    StreamChecker* obj = (StreamChecker*)malloc(sizeof(StreamChecker));
    obj->root = createNode();
    obj->buffer = (char*)malloc(256 * sizeof(char));
    obj->bufferLen = 0;
    for (int i = 0; i < wordsSize; ++i) {
        insert(obj->root, words[i]);
    }
    return obj;
}

void streamCheckerFree(StreamChecker* obj) {
    free(obj->buffer);
    free(obj->root);
    free(obj);
}

int streamCheckerQuery(StreamChecker* obj, char ch) {
    obj->buffer[obj->bufferLen++] = ch;
    if (obj->bufferLen > 255) {
        memmove(obj->buffer, obj->buffer + 1, 255 * sizeof(char));
        obj->bufferLen = 255;
    }
    TrieNode* node = obj->root;
    for (int i = obj->bufferLen - 1; i >= 0; --i) {
        int index = obj->buffer[i] - 'a';
        if (!node->children[index]) {
            return 0;
        }
        node = node->children[index];
        if (node->isEnd) {
            return 1;
        }
    }
    return 0;