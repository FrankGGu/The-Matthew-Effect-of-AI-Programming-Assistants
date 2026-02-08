#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode *children[26];
    bool isEndOfWord;
} TrieNode;

typedef struct {
    TrieNode *root;
} MagicDictionary;

TrieNode* createTrieNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    if (node == NULL) {
        return NULL;
    }
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->isEndOfWord = false;
    return node;
}

MagicDictionary* magicDictionaryCreate() {
    MagicDictionary* obj = (MagicDictionary*)malloc(sizeof(MagicDictionary));
    if (obj == NULL) {
        return NULL;
    }
    obj->root = createTrieNode();
    return obj;
}

void magicDictionaryBuildDict(MagicDictionary* obj, char **dictionary, int dictionarySize) {
    for (int i = 0; i < dictionarySize; i++) {
        char *word = dictionary[i];
        TrieNode *curr = obj->root;
        for (int j = 0; word[j] != '\0'; j++) {
            int idx = word[j] - 'a';
            if (curr->children[idx] == NULL) {
                curr->children[idx] = createTrieNode();
            }
            curr = curr->children[idx];
        }
        curr->isEndOfWord = true;
    }
}

bool dfsSearch(TrieNode *node, char *word, int k, int diffCount, int wordLen) {
    if (node == NULL) {
        return false;
    }

    if (k == wordLen) {
        return node->isEndOfWord && diffCount == 1;
    }

    for (int i = 0; i < 26; i++) {
        int newDiffCount = diffCount;

        if (('a' + i) != word[k]) {
            newDiffCount++;
        }

        if (newDiffCount > 1) {
            continue;
        }

        if (dfsSearch(node->children[i], word, k + 1, newDiffCount, wordLen)) {
            return true;
        }
    }

    return false;
}

bool magicDictionarySearch(MagicDictionary* obj, char *searchWord) {
    return dfsSearch(obj->root, searchWord, 0, 0, strlen(searchWord));
}

void freeTrieNode(TrieNode *node) {
    if (node == NULL) {
        return;
    }
    for (int i = 0; i < 26; i++) {
        freeTrieNode(node->children[i]);
    }
    free(node);
}

void magicDictionaryFree(MagicDictionary* obj) {
    if (obj == NULL) {
        return;
    }
    freeTrieNode(obj->root);
    free(obj);
}