#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TrieNode {
    int index;
    struct TrieNode* children[26];
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->index = -1;
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    return node;
}

void insert(TrieNode* root, char* word, int index) {
    TrieNode* curr = root;
    for (int i = strlen(word) - 1; i >= 0; i--) {
        int charIndex = word[i] - 'a';
        if (curr->children[charIndex] == NULL) {
            curr->children[charIndex] = createNode();
        }
        curr = curr->children[charIndex];
    }
    curr->index = index;
}

int isPalindrome(char* str, int start, int end) {
    while (start < end) {
        if (str[start] != str[end]) {
            return 0;
        }
        start++;
        end--;
    }
    return 1;
}

int** palindromePairs(char** words, int wordsSize, int* returnSize, int** returnColumnSizes) {
    TrieNode* root = createNode();
    for (int i = 0; i < wordsSize; i++) {
        insert(root, words[i], i);
    }

    int** result = (int**)malloc(wordsSize * wordsSize * sizeof(int*));
    *returnSize = 0;
    *returnColumnSizes = (int*)malloc(wordsSize * wordsSize * sizeof(int));

    for (int i = 0; i < wordsSize; i++) {
        TrieNode* curr = root;
        char* word = words[i];
        int len = strlen(word);
        for (int j = 0; j < len; j++) {
            if (curr->index != -1 && curr->index != i && isPalindrome(word, j, len - 1)) {
                result[*returnSize] = (int*)malloc(2 * sizeof(int));
                result[*returnSize][0] = i;
                result[*returnSize][1] = curr->index;
                (*returnColumnSizes)[*returnSize] = 2;
                (*returnSize)++;
            }
            int charIndex = word[j] - 'a';
            if (curr->children[charIndex] == NULL) {
                curr = NULL;
                break;
            }
            curr = curr->children[charIndex];
        }

        if (curr != NULL && curr->index != -1 && curr->index != i) {
            result[*returnSize] = (int*)malloc(2 * sizeof(int));
            result[*returnSize][0] = i;
            result[*returnSize][1] = curr->index;
            (*returnColumnSizes)[*returnSize] = 2;
            (*returnSize)++;
        }

        curr = root;
        for (int j = len - 1; j >= 0; j--) {
            int charIndex = word[j] - 'a';
            if (curr->children[charIndex] == NULL) break;
            curr = curr->children[charIndex];
            if (curr->index != -1 && curr->index != i && isPalindrome(word, 0, j - 1)) {
                result[*returnSize] = (int*)malloc(2 * sizeof(int));
                result[*returnSize][0] = curr->index;
                result[*returnSize][1] = i;
                (*returnColumnSizes)[*returnSize] = 2;
                (*returnSize)++;
            }
        }
    }

    return result;
}