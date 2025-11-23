#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct TrieNode {
    struct TrieNode* children[26];
    bool isEndOfWord;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->isEndOfWord = false;
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
    }
    curr->isEndOfWord = true;
}

int searchShortestRootLength(TrieNode* root, char* word) {
    TrieNode* curr = root;
    int len = 0;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (curr->children[index] == NULL) {
            return 0;
        }
        curr = curr->children[index];
        len++;
        if (curr->isEndOfWord) {
            return len;
        }
    }
    return 0;
}

void freeTrie(TrieNode* node) {
    if (node == NULL) return;
    for (int i = 0; i < 26; i++) {
        freeTrie(node->children[i]);
    }
    free(node);
}

char* replaceWords(char** dictionary, int dictionarySize, char* sentence) {
    TrieNode* root = createNode();
    for (int i = 0; i < dictionarySize; i++) {
        insert(root, dictionary[i]);
    }

    char* result = (char*)malloc(strlen(sentence) + 1);
    char* currentResultPtr = result;

    char* sentenceCopy = strdup(sentence);
    char* word = strtok(sentenceCopy, " ");
    bool firstWord = true;

    while (word != NULL) {
        if (!firstWord) {
            *currentResultPtr = ' ';
            currentResultPtr++;
        }

        int shortestRootLen = searchShortestRootLength(root, word);

        if (shortestRootLen > 0) {
            strncpy(currentResultPtr, word, shortestRootLen);
            currentResultPtr += shortestRootLen;
        } else {
            strcpy(currentResultPtr, word);
            currentResultPtr += strlen(word);
        }

        firstWord = false;
        word = strtok(NULL, " ");
    }
    *currentResultPtr = '\0';

    free(sentenceCopy);
    freeTrie(root);

    return result;
}