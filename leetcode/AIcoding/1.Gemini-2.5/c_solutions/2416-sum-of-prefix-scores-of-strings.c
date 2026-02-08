#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[26];
    int count;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    if (node) {
        node->count = 0;
        for (int i = 0; i < 26; i++) {
            node->children[i] = NULL;
        }
    }
    return node;
}

void insert(TrieNode* root, char* word) {
    TrieNode* curr = root;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (curr->children[index] == NULL) {
            curr->children[index] = createNode();
        }
        curr = curr->children[index];
        curr->count++;
    }
}

int calculateScore(TrieNode* root, char* word) {
    int score = 0;
    TrieNode* curr = root;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        curr = curr->children[index];
        score += curr->count;
    }
    return score;
}

void freeTrie(TrieNode* node) {
    if (!node) {
        return;
    }
    for (int i = 0; i < 26; i++) {
        freeTrie(node->children[i]);
    }
    free(node);
}

int* sumPrefixScores(char** words, int wordsSize, int* returnSize) {
    TrieNode* root = createNode();

    for (int i = 0; i < wordsSize; i++) {
        insert(root, words[i]);
    }

    int* scores = (int*)malloc(sizeof(int) * wordsSize);
    if (!scores) {
        *returnSize = 0;
        freeTrie(root);
        return NULL;
    }

    for (int i = 0; i < wordsSize; i++) {
        scores[i] = calculateScore(root, words[i]);
    }

    *returnSize = wordsSize;

    freeTrie(root);

    return scores;
}