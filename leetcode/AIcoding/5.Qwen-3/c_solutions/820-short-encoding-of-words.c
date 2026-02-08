#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[26];
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    return node;
}

int insert(TrieNode* root, char* word) {
    TrieNode* node = root;
    int len = 0;
    for (int i = 0; word[i]; i++) {
        int index = word[i] - 'a';
        if (!node->children[index]) {
            node->children[index] = createNode();
        }
        node = node->children[index];
        len++;
    }
    return len;
}

int countEncoding(TrieNode* root, char* word, int depth) {
    TrieNode* node = root;
    for (int i = 0; word[i]; i++) {
        int index = word[i] - 'a';
        node = node->children[index];
    }
    for (int i = 0; i < 26; i++) {
        if (node->children[i]) {
            return 0;
        }
    }
    return depth;
}

int minimumEncoding(char** words, int wordsSize) {
    TrieNode* root = createNode();
    int totalLength = 0;
    for (int i = 0; i < wordsSize; i++) {
        int len = insert(root, words[i]);
        totalLength += len;
    }

    int result = 0;
    for (int i = 0; i < wordsSize; i++) {
        int depth = 0;
        TrieNode* node = root;
        for (int j = 0; words[i][j]; j++) {
            int index = words[i][j] - 'a';
            node = node->children[index];
            depth++;
        }
        int isLeaf = 1;
        for (int j = 0; j < 26; j++) {
            if (node->children[j]) {
                isLeaf = 0;
                break;
            }
        }
        if (isLeaf) {
            result += depth + 1;
        }
    }

    return result;
}