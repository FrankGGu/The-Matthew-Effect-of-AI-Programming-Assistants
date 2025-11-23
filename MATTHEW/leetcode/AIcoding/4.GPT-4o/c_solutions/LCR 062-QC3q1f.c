typedef struct TrieNode {
    struct TrieNode *children[26];
    bool isEndOfWord;
} TrieNode;

typedef struct Trie {
    TrieNode *root;
} Trie;

TrieNode* createNode() {
    TrieNode *node = (TrieNode *)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->isEndOfWord = false;
    return node;
}

Trie* trieCreate() {
    Trie *trie = (Trie *)malloc(sizeof(Trie));
    trie->root = createNode();
    return trie;
}

void trieInsert(Trie* obj, char* word) {
    TrieNode *node = obj->root;
    while (*word) {
        int index = *word - 'a';
        if (!node->children[index]) {
            node->children[index] = createNode();
        }
        node = node->children[index];
        word++;
    }
    node->isEndOfWord = true;
}

bool trieSearch(Trie* obj, char* word) {
    TrieNode *node = obj->root;
    while (*word) {
        int index = *word - 'a';
        if (!node->children[index]) {
            return false;
        }
        node = node->children[index];
        word++;
    }
    return node->isEndOfWord;
}

bool trieStartsWith(Trie* obj, char* prefix) {
    TrieNode *node = obj->root;
    while (*prefix) {
        int index = *prefix - 'a';
        if (!node->children[index]) {
            return false;
        }
        node = node->children[index];
        prefix++;
    }
    return true;
}

void trieFree(Trie* obj) {
    void freeNode(TrieNode* node) {
        for (int i = 0; i < 26; i++) {
            if (node->children[i]) {
                freeNode(node->children[i]);
            }
        }
        free(node);
    }
    freeNode(obj->root);
    free(obj);
}