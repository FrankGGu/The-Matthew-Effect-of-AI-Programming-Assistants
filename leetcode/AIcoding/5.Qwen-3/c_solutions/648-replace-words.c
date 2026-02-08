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
    TrieNode* node = root;
    for (int i = 0; i < strlen(word); i++) {
        int index = word[i] - 'a';
        if (!node->children[index]) {
            node->children[index] = createNode();
        }
        node = node->children[index];
    }
    node->isEnd = 1;
}

char* replaceWords(TrieNode* root, char* sentence) {
    int len = strlen(sentence);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int idx = 0;
    int i = 0;
    while (i < len) {
        if (sentence[i] == ' ') {
            result[idx++] = ' ';
            i++;
            continue;
        }
        char* word = (char*)malloc(26 * sizeof(char));
        int j = 0;
        TrieNode* node = root;
        while (i < len && sentence[i] != ' ') {
            int index = sentence[i] - 'a';
            if (!node->children[index]) {
                break;
            }
            node = node->children[index];
            word[j++] = sentence[i++];
            if (node->isEnd) {
                break;
            }
        }
        word[j] = '\0';
        if (node->isEnd) {
            strcpy(&result[idx], word);
            idx += j;
        } else {
            int k = 0;
            while (i > 0 && sentence[i - 1] != ' ') {
                i--;
                k++;
            }
            strncpy(&result[idx], &sentence[i], k);
            idx += k;
            i += k;
        }
        free(word);
    }
    result[idx] = '\0';
    return result;
}

char* replaceWordsWrapper(char** dictionary, int dictionarySize, char* sentence) {
    TrieNode* root = createNode();
    for (int i = 0; i < dictionarySize; i++) {
        insert(root, dictionary[i]);
    }
    return replaceWords(root, sentence);
}