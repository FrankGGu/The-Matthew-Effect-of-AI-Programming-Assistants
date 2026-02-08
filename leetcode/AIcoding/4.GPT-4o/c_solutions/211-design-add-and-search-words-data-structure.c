typedef struct TrieNode {
    struct TrieNode *children[26];
    bool isEndOfWord;
} TrieNode;

typedef struct WordDictionary {
    TrieNode *root;
} WordDictionary;

TrieNode* createNode() {
    TrieNode *node = (TrieNode *)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->isEndOfWord = false;
    return node;
}

WordDictionary* wordDictionaryCreate() {
    WordDictionary *wd = (WordDictionary *)malloc(sizeof(WordDictionary));
    wd->root = createNode();
    return wd;
}

void addWord(WordDictionary* obj, char* word) {
    TrieNode *node = obj->root;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (node->children[index] == NULL) {
            node->children[index] = createNode();
        }
        node = node->children[index];
    }
    node->isEndOfWord = true;
}

bool searchHelper(TrieNode *node, char *word, int index) {
    if (index == strlen(word)) {
        return node->isEndOfWord;
    }
    if (word[index] == '.') {
        for (int i = 0; i < 26; i++) {
            if (node->children[i] != NULL && searchHelper(node->children[i], word, index + 1)) {
                return true;
            }
        }
        return false;
    } else {
        int idx = word[index] - 'a';
        if (node->children[idx] == NULL) {
            return false;
        }
        return searchHelper(node->children[idx], word, index + 1);
    }
}

bool search(WordDictionary* obj, char* word) {
    return searchHelper(obj->root, word, 0);
}

void wordDictionaryFree(WordDictionary* obj) {
    // A function to free the memory allocated for the WordDictionary.
    // Implementation is omitted for brevity.
    free(obj);
}