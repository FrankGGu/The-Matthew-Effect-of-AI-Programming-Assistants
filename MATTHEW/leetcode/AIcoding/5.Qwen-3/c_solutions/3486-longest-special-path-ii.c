#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    char *word;
    struct Node *children[26];
} Node;

Node* createNode(char *word) {
    Node *newNode = (Node*)malloc(sizeof(Node));
    newNode->word = strdup(word);
    for (int i = 0; i < 26; i++) {
        newNode->children[i] = NULL;
    }
    return newNode;
}

void insertWord(Node *root, char *word) {
    Node *current = root;
    for (int i = 0; word[i]; i++) {
        int index = word[i] - 'a';
        if (!current->children[index]) {
            current->children[index] = createNode("");
        }
        current = current->children[index];
    }
    current->word = strdup(word);
}

int dfs(Node *node, int depth, char prevChar) {
    if (!node) return 0;
    int maxLen = 0;
    for (int i = 0; i < 26; i++) {
        if (node->children[i] && (prevChar == '\0' || (i > (prevChar - 'a')))) {
            int len = dfs(node->children[i], depth + 1, (char)('a' + i));
            if (len > maxLen) {
                maxLen = len;
            }
        }
    }
    return maxLen + (strlen(node->word) > 0 ? 1 : 0);
}

int longestSpecialPath(char **words, int wordsSize) {
    Node *root = createNode("");
    for (int i = 0; i < wordsSize; i++) {
        insertWord(root, words[i]);
    }
    return dfs(root, 0, '\0');
}