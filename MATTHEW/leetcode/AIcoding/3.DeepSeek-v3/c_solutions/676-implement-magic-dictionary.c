typedef struct TrieNode {
    struct TrieNode* children[26];
    bool isEnd;
} TrieNode;

typedef struct {
    TrieNode* root;
} MagicDictionary;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->isEnd = false;
    return node;
}

MagicDictionary* magicDictionaryCreate() {
    MagicDictionary* obj = (MagicDictionary*)malloc(sizeof(MagicDictionary));
    obj->root = createNode();
    return obj;
}

void magicDictionaryBuildDict(MagicDictionary* obj, char** dictionary, int dictionarySize) {
    for (int i = 0; i < dictionarySize; i++) {
        TrieNode* node = obj->root;
        char* word = dictionary[i];
        for (int j = 0; word[j]; j++) {
            int idx = word[j] - 'a';
            if (!node->children[idx]) {
                node->children[idx] = createNode();
            }
            node = node->children[idx];
        }
        node->isEnd = true;
    }
}

bool searchHelper(TrieNode* node, char* word, int index, bool modified) {
    if (!word[index]) {
        return node->isEnd && modified;
    }

    int idx = word[index] - 'a';
    if (node->children[idx]) {
        if (searchHelper(node->children[idx], word, index + 1, modified)) {
            return true;
        }
    }

    if (!modified) {
        for (int i = 0; i < 26; i++) {
            if (i != idx && node->children[i]) {
                if (searchHelper(node->children[i], word, index + 1, true)) {
                    return true;
                }
            }
        }
    }

    return false;
}

bool magicDictionarySearch(MagicDictionary* obj, char* searchWord) {
    return searchHelper(obj->root, searchWord, 0, false);
}

void freeTrie(TrieNode* node) {
    if (!node) return;
    for (int i = 0; i < 26; i++) {
        freeTrie(node->children[i]);
    }
    free(node);
}

void magicDictionaryFree(MagicDictionary* obj) {
    freeTrie(obj->root);
    free(obj);
}