typedef struct TrieNode {
    struct TrieNode* children[26];
    bool isEnd;
} TrieNode;

typedef struct {
    TrieNode* root;
} WordDictionary;

TrieNode* trieNodeCreate() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->isEnd = false;
    return node;
}

WordDictionary* wordDictionaryCreate() {
    WordDictionary* obj = (WordDictionary*)malloc(sizeof(WordDictionary));
    obj->root = trieNodeCreate();
    return obj;
}

void wordDictionaryAddWord(WordDictionary* obj, char* word) {
    TrieNode* node = obj->root;
    for (int i = 0; word[i]; i++) {
        char c = word[i];
        if (!node->children[c - 'a']) {
            node->children[c - 'a'] = trieNodeCreate();
        }
        node = node->children[c - 'a'];
    }
    node->isEnd = true;
}

bool searchHelper(TrieNode* node, char* word) {
    for (int i = 0; word[i]; i++) {
        char c = word[i];
        if (c == '.') {
            for (int j = 0; j < 26; j++) {
                if (node->children[j] && searchHelper(node->children[j], word + i + 1)) {
                    return true;
                }
            }
            return false;
        } else {
            if (!node->children[c - 'a']) {
                return false;
            }
            node = node->children[c - 'a'];
        }
    }
    return node->isEnd;
}

bool wordDictionarySearch(WordDictionary* obj, char* word) {
    return searchHelper(obj->root, word);
}

void trieNodeFree(TrieNode* node) {
    if (!node) return;
    for (int i = 0; i < 26; i++) {
        trieNodeFree(node->children[i]);
    }
    free(node);
}

void wordDictionaryFree(WordDictionary* obj) {
    trieNodeFree(obj->root);
    free(obj);
}