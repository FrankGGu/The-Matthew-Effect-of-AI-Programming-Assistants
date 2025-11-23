#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* word;
    int index;
} Pair;

typedef struct {
    char** words;
    int size;
    int capacity;
} WordList;

typedef struct {
    char** words;
    int* indices;
    int count;
} Result;

typedef struct {
    char** words;
    int* indices;
    int count;
} TrieNode;

TrieNode* createTrieNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->words = NULL;
    node->indices = NULL;
    node->count = 0;
    return node;
}

void addWordToTrie(TrieNode* root, char* word, int index) {
    TrieNode* node = root;
    for (int i = 0; word[i]; i++) {
        int c = word[i] - 'a';
        if (!node->words[c]) {
            node->words[c] = (char*)malloc(100 * sizeof(char));
            node->indices[c] = (int*)malloc(100 * sizeof(int));
        }
        node->words[c][node->count] = word[i];
        node->indices[c][node->count] = index;
        node->count++;
    }
}

int isPalindrome(char* s) {
    int left = 0;
    int right = strlen(s) - 1;
    while (left < right) {
        if (s[left] != s[right]) return 0;
        left++;
        right--;
    }
    return 1;
}

Result* palindromePairs(char** words, int wordsSize) {
    Result* result = (Result*)malloc(sizeof(Result));
    result->words = (char**)malloc(wordsSize * sizeof(char*));
    result->indices = (int*)malloc(wordsSize * sizeof(int));
    result->count = 0;

    TrieNode* root = createTrieNode();
    for (int i = 0; i < wordsSize; i++) {
        addWordToTrie(root, words[i], i);
    }

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int len = strlen(word);
        for (int j = 0; j < len; j++) {
            char* prefix = (char*)malloc(j + 1);
            strncpy(prefix, word, j);
            prefix[j] = '\0';
            char* suffix = (char*)malloc(len - j + 1);
            strcpy(suffix, word + j);

            if (isPalindrome(prefix)) {
                for (int k = 0; k < root->count; k++) {
                    char* revSuffix = (char*)malloc(len - j + 1);
                    strcpy(revSuffix, suffix);
                    int revLen = strlen(revSuffix);
                    for (int l = 0; l < revLen; l++) {
                        revSuffix[l] = revSuffix[revLen - 1 - l];
                    }
                    if (strcmp(revSuffix, root->words[k]) == 0) {
                        if (i != root->indices[k]) {
                            result->words[result->count] = (char*)malloc(2 * sizeof(char));
                            sprintf(result->words[result->count], "%d %d", i, root->indices[k]);
                            result->indices[result->count++] = i;
                        }
                    }
                }
            }

            if (isPalindrome(suffix)) {
                for (int k = 0; k < root->count; k++) {
                    char* revPrefix = (char*)malloc(j + 1);
                    strncpy(revPrefix, word, j);
                    revPrefix[j] = '\0';
                    int revLen = strlen(revPrefix);
                    for (int l = 0; l < revLen; l++) {
                        revPrefix[l] = revPrefix[revLen - 1 - l];
                    }
                    if (strcmp(revPrefix, root->words[k]) == 0) {
                        if (i != root->indices[k]) {
                            result->words[result->count] = (char*)malloc(2 * sizeof(char));
                            sprintf(result->words[result->count], "%d %d", i, root->indices[k]);
                            result->indices[result->count++] = i;
                        }
                    }
                }
            }
            free(prefix);
            free(suffix);
        }
    }

    return result;
}