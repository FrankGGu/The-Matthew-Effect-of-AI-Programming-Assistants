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
    TrieNode* current = root;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (!current->children[index]) {
            current->children[index] = createNode();
        }
        current = current->children[index];
    }
    current->isEnd = 1;
}

char* replaceWords(TrieNode* root, char* sentence) {
    char* result = (char*)malloc(10000 * sizeof(char));
    char* token = strtok(sentence, " ");
    int index = 0;
    while (token != NULL) {
        TrieNode* current = root;
        int found = 0;
        for (int i = 0; token[i] != '\0'; i++) {
            int indexChar = token[i] - 'a';
            if (!current->children[indexChar]) {
                break;
            }
            current = current->children[indexChar];
            if (current->isEnd) {
                found = 1;
                break;
            }
        }
        if (found) {
            strncpy(result + index, token, i + 1);
            index += i + 1;
        } else {
            strncpy(result + index, token, strlen(token) + 1);
            index += strlen(token);
        }
        result[index++] = ' ';
        token = strtok(NULL, " ");
    }
    result[index - 1] = '\0';
    return result;
}

char* replaceWords(char** dictionary, int dictionarySize, char* sentence) {
    TrieNode* root = createNode();
    for (int i = 0; i < dictionarySize; i++) {
        insert(root, dictionary[i]);
    }
    return replaceWords(root, sentence);
}