#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *key;
    int count;
} TrieNode;

TrieNode* createNode() {
    TrieNode *node = (TrieNode*)malloc(sizeof(TrieNode));
    node->key = NULL;
    node->count = 0;
    return node;
}

int compare(const void *a, const void *b) {
    return strcmp(((TrieNode*)a)->key, ((TrieNode*)b)->key);
}

int longestSpecialSubstrings(char **s, int sSize) {
    int result = -1;
    TrieNode **trie = (TrieNode**)calloc(26, sizeof(TrieNode*));
    for (int i = 0; i < 26; i++) {
        trie[i] = createNode();
    }

    for (int i = 0; i < sSize; i++) {
        char *str = s[i];
        int len = strlen(str);
        int j = 0;
        while (j < len) {
            int k = j;
            while (k < len && str[k] == str[j]) {
                k++;
            }
            int subLen = k - j;
            for (int l = 1; l <= subLen; l++) {
                char *sub = (char*)malloc((l + 1) * sizeof(char));
                memset(sub, str[j], l);
                sub[l] = '\0';
                int idx = str[j] - 'a';
                TrieNode *current = trie[idx];
                if (!current->key) {
                    current->key = sub;
                    current->count = 1;
                } else {
                    int cmp = strcmp(current->key, sub);
                    if (cmp == 0) {
                        current->count++;
                    } else {
                        TrieNode *newNode = createNode();
                        newNode->key = sub;
                        newNode->count = 1;
                        TrieNode *temp = trie[idx];
                        while (temp->key && strcmp(temp->key, sub) > 0) {
                            temp = temp->next;
                        }
                        newNode->next = temp->next;
                        temp->next = newNode;
                    }
                }
            }
            j = k;
        }
    }

    for (int i = 0; i < 26; i++) {
        TrieNode *current = trie[i];
        while (current) {
            if (current->count >= 3) {
                int len = strlen(current->key);
                if (len > result) {
                    result = len;
                }
            }
            current = current->next;
        }
    }

    for (int i = 0; i < 26; i++) {
        TrieNode *current = trie[i];
        while (current) {
            TrieNode *next = current->next;
            free(current->key);
            free(current);
            current = next;
        }
    }
    free(trie);
    return result;
}