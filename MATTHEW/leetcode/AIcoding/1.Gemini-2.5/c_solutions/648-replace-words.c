#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define ALPHABET_SIZE 26

typedef struct TrieNode {
    struct TrieNode* children[ALPHABET_SIZE];
    bool isEndOfWord;
} TrieNode;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    if (node) {
        for (int i = 0; i < ALPHABET_SIZE; i++) {
            node->children[i] = NULL;
        }
        node->isEndOfWord = false;
    }
    return node;
}

void insert(TrieNode* root, const char* word) {
    TrieNode* curr = root;
    for (int i = 0; i < strlen(word); i++) {
        int index = word[i] - 'a';
        if (!curr->children[index]) {
            curr->children[index] = createNode();
        }
        curr = curr->children[index];
    }
    curr->isEndOfWord = true;
}

char* findShortestRoot(TrieNode* root, const char* word) {
    TrieNode* curr = root;
    int len = strlen(word);
    char* prefix = (char*)malloc((len + 1) * sizeof(char));
    if (!prefix) return NULL;

    for (int i = 0; i < len; i++) {
        int index = word[i] - 'a';
        if (!curr->children[index]) {
            free(prefix);
            return NULL; 
        }
        prefix[i] = word[i];
        prefix[i+1] = '\0';
        curr = curr->children[index];
        if (curr->isEndOfWord) {
            return prefix; 
        }
    }
    free(prefix);
    return NULL; 
}

void freeTrie(TrieNode* root) {
    if (!root) return;
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        freeTrie(root->children[i]);
    }
    free(root);
}

char* replaceWords(char** dictionary, int dictionarySize, char* sentence) {
    TrieNode* root = createNode();
    for (int i = 0; i < dictionarySize; i++) {
        insert(root, dictionary[i]);
    }

    int sentenceLen = strlen(sentence);
    char* result = (char*)malloc((sentenceLen + 1) * sizeof(char));
    if (!result) {
        freeTrie(root);
        return NULL;
    }
    result[0] = '\0';

    char* token;
    char* rest = sentence;

    while ((token = strtok_r(rest, " ", &rest))) {
        char* shortestRoot = findShortestRoot(root, token);
        if (shortestRoot) {
            strcat(result, shortestRoot);
            free(shortestRoot);
        } else {
            strcat(result, token);
        }
        if (strlen(rest) > 0) {
            strcat(result, " ");
        }
    }

    freeTrie(root);
    return result;
}