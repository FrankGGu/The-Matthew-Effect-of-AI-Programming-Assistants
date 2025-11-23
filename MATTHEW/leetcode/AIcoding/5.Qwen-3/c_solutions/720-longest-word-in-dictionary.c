#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode *children[26];
    int isEnd;
} TrieNode;

TrieNode* createNode() {
    TrieNode *node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->isEnd = 0;
    return node;
}

void insert(TrieNode *root, char *word) {
    TrieNode *current = root;
    for (int i = 0; word[i]; i++) {
        int index = word[i] - 'a';
        if (!current->children[index]) {
            current->children[index] = createNode();
        }
        current = current->children[index];
    }
    current->isEnd = 1;
}

char* longestWord(TrieNode *root, char *words[], int wordsSize) {
    char *result = (char*)malloc(100 * sizeof(char));
    int maxLen = 0;

    for (int i = 0; i < wordsSize; i++) {
        TrieNode *current = root;
        int valid = 1;
        for (int j = 0; words[i][j]; j++) {
            int index = words[i][j] - 'a';
            if (!current->children[index] || !current->isEnd) {
                valid = 0;
                break;
            }
            current = current->children[index];
        }
        if (valid && current->isEnd) {
            int len = strlen(words[i]);
            if (len > maxLen) {
                maxLen = len;
                strcpy(result, words[i]);
            } else if (len == maxLen) {
                if (strcmp(words[i], result) < 0) {
                    strcpy(result, words[i]);
                }
            }
        }
    }

    return result;
}