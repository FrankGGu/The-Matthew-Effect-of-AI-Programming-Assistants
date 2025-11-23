#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    int count;
    struct TrieNode *children[26];
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->count = 0;
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    return node;
}

void insert(TrieNode* root, const char* word) {
    TrieNode* current = root;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (current->children[index] == NULL) {
            current->children[index] = createNode();
        }
        current = current->children[index];
    }
    current->count++;
}

long long countWords(TrieNode* root, const char* word) {
    TrieNode* current = root;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (current->children[index] == NULL) {
            return 0;
        }
        current = current->children[index];
    }
    return current->count;
}

long long countPrefixSuffixPairs(char ** words, int wordsSize) {
    long long count = 0;
    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            int len1 = strlen(words[i]);
            int len2 = strlen(words[j]);

            int isPrefix = 0;
            if (len1 <= len2) {
                isPrefix = 1;
                for (int k = 0; k < len1; k++) {
                    if (words[i][k] != words[j][k]) {
                        isPrefix = 0;
                        break;
                    }
                }
            }

            int isSuffix = 0;
            if (len1 <= len2) {
                isSuffix = 1;
                for (int k = 0; k < len1; k++) {
                    if (words[i][len1 - 1 - k] != words[j][len2 - 1 - k]) {
                        isSuffix = 0;
                        break;
                    }
                }
            }

            if (isPrefix && isSuffix) {
                count++;
            }
        }
    }
    return count;
}