#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[26];
    int isEnd;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->isEnd = 0;
    return node;
}

void insert(TrieNode* root, char* word) {
    TrieNode* node = root;
    for (int i = 0; word[i]; i++) {
        int idx = word[i] - 'a';
        if (!node->children[idx]) {
            node->children[idx] = createNode();
        }
        node = node->children[idx];
    }
    node->isEnd = 1;
}

int search(TrieNode* root, char* word) {
    TrieNode* node = root;
    for (int i = 0; word[i]; i++) {
        int idx = word[i] - 'a';
        if (!node->children[idx] || !node->children[idx]->isEnd) {
            return 0;
        }
        node = node->children[idx];
    }
    return node->isEnd;
}

char* longestWord(char** words, int wordsSize) {
    TrieNode* root = createNode();
    for (int i = 0; i < wordsSize; i++) {
        insert(root, words[i]);
    }

    char* result = "";
    for (int i = 0; i < wordsSize; i++) {
        if (search(root, words[i])) {
            if (strlen(words[i]) > strlen(result)) {
                result = words[i];
            } else if (strlen(words[i]) == strlen(result) && strcmp(words[i], result) < 0) {
                result = words[i];
            }
        }
    }
    return result;
}