#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    int count;
    struct TrieNode* children[26];
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->count = 0;
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    return node;
}

void insert(TrieNode* root, char* word) {
    TrieNode* current = root;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (current->children[index] == NULL) {
            current->children[index] = createNode();
        }
        current = current->children[index];
        current->count++;
    }
}

int prefixScore(TrieNode* root, char* word) {
    TrieNode* current = root;
    int score = 0;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        current = current->children[index];
        score += current->count;
    }
    return score;
}

int* sumPrefixScores(char** words, int wordsSize, int* returnSize) {
    TrieNode* root = createNode();
    for (int i = 0; i < wordsSize; i++) {
        insert(root, words[i]);
    }

    int* result = (int*)malloc(wordsSize * sizeof(int));
    *returnSize = wordsSize;

    for (int i = 0; i < wordsSize; i++) {
        result[i] = prefixScore(root, words[i]);
    }

    return result;
}