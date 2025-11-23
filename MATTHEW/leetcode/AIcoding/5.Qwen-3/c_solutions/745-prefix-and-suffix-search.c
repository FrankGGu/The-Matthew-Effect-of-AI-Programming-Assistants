#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *word;
    int index;
} TrieNode;

typedef struct {
    TrieNode *children[27];
} Trie;

Trie* createTrie() {
    Trie *node = (Trie*)malloc(sizeof(Trie));
    for (int i = 0; i < 27; i++) {
        node->children[i] = NULL;
    }
    return node;
}

void insert(Trie *root, char *word, int index) {
    Trie *node = root;
    for (int i = 0; word[i]; i++) {
        int c = word[i] - 'a';
        if (!node->children[c]) {
            node->children[c] = createTrie();
        }
        node = node->children[c];
    }
    TrieNode *newNode = (TrieNode*)malloc(sizeof(TrieNode));
    newNode->word = strdup(word);
    newNode->index = index;
    node->children[26] = newNode;
}

int search(Trie *root, char *prefix) {
    Trie *node = root;
    for (int i = 0; prefix[i]; i++) {
        int c = prefix[i] - 'a';
        if (!node->children[c]) {
            return -1;
        }
        node = node->children[c];
    }
    TrieNode *current = node->children[26];
    if (!current) return -1;
    return current->index;
}

typedef struct {
    Trie *prefixTrie;
    Trie *suffixTrie;
} PrefixSuffixSearch;

PrefixSuffixSearch* prefixSuffixSearchCreate(char **words, int wordsSize) {
    PrefixSuffixSearch *obj = (PrefixSuffixSearch*)malloc(sizeof(PrefixSuffixSearch));
    obj->prefixTrie = createTrie();
    obj->suffixTrie = createTrie();
    for (int i = 0; i < wordsSize; i++) {
        char *word = words[i];
        insert(obj->prefixTrie, word, i);
        int len = strlen(word);
        char *reversed = (char*)malloc(len + 1);
        for (int j = 0; j < len; j++) {
            reversed[j] = word[len - 1 - j];
        }
        reversed[len] = '\0';
        insert(obj->suffixTrie, reversed, i);
        free(reversed);
    }
    return obj;
}

int prefixSuffixSearchQuery(PrefixSuffixSearch* obj, char *prefix, char *suffix) {
    int prefixIndex = search(obj->prefixTrie, prefix);
    if (prefixIndex == -1) return -1;
    int len = strlen(suffix);
    char *reversedSuffix = (char*)malloc(len + 1);
    for (int i = 0; i < len; i++) {
        reversedSuffix[i] = suffix[len - 1 - i];
    }
    reversedSuffix[len] = '\0';
    int suffixIndex = search(obj->suffixTrie, reversedSuffix);
    free(reversedSuffix);
    if (suffixIndex == -1) return -1;
    return (prefixIndex == suffixIndex) ? prefixIndex : -1;
}

void prefixSuffixSearchFree(PrefixSuffixSearch* obj) {
    free(obj);
}