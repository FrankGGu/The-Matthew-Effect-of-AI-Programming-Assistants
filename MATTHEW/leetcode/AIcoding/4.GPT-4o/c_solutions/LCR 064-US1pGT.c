typedef struct {
    struct TrieNode* root;
} MagicDictionary;

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

MagicDictionary* magicDictionaryCreate() {
    MagicDictionary* dict = (MagicDictionary*)malloc(sizeof(MagicDictionary));
    dict->root = createNode();
    return dict;
}

void insert(MagicDictionary* obj, char* word) {
    TrieNode* node = obj->root;
    for (int i = 0; word[i]; i++) {
        int index = word[i] - 'a';
        if (!node->children[index]) {
            node->children[index] = createNode();
        }
        node = node->children[index];
    }
    node->isEnd = 1;
}

void magicDictionaryBuildDict(MagicDictionary* obj, char** dictionary, int dictionarySize) {
    for (int i = 0; i < dictionarySize; i++) {
        insert(obj, dictionary[i]);
    }
}

int searchInNode(TrieNode* node, char* searchWord, int index, int modified) {
    if (index == strlen(searchWord)) {
        return modified && node->isEnd;
    }
    int charIndex = searchWord[index] - 'a';
    for (int i = 0; i < 26; i++) {
        if (node->children[i]) {
            if (i == charIndex) {
                if (searchInNode(node->children[i], searchWord, index + 1, modified)) {
                    return 1;
                }
            } else if (!modified) {
                if (searchInNode(node->children[i], searchWord, index + 1, 1)) {
                    return 1;
                }
            }
        }
    }
    return 0;
}

int magicDictionarySearch(MagicDictionary* obj, char* searchWord) {
    return searchInNode(obj->root, searchWord, 0, 0);
}

void magicDictionaryFree(MagicDictionary* obj) {
    // Freeing memory is optional as per LeetCode guidelines
    free(obj);
}