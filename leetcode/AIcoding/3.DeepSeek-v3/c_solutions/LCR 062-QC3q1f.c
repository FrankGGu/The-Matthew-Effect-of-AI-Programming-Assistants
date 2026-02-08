typedef struct TrieNode {
    struct TrieNode* children[26];
    bool isEnd;
} Trie;

Trie* trieCreate() {
    Trie* node = (Trie*)malloc(sizeof(Trie));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->isEnd = false;
    return node;
}

void trieInsert(Trie* obj, char* word) {
    Trie* node = obj;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (node->children[index] == NULL) {
            node->children[index] = trieCreate();
        }
        node = node->children[index];
    }
    node->isEnd = true;
}

bool trieSearch(Trie* obj, char* word) {
    Trie* node = obj;
    for (int i = 0; word[i] != '\0'; i++) {
        int index = word[i] - 'a';
        if (node->children[index] == NULL) {
            return false;
        }
        node = node->children[index];
    }
    return node->isEnd;
}

bool trieStartsWith(Trie* obj, char* prefix) {
    Trie* node = obj;
    for (int i = 0; prefix[i] != '\0'; i++) {
        int index = prefix[i] - 'a';
        if (node->children[index] == NULL) {
            return false;
        }
        node = node->children[index];
    }
    return true;
}

void trieFree(Trie* obj) {
    if (obj == NULL) return;
    for (int i = 0; i < 26; i++) {
        trieFree(obj->children[i]);
    }
    free(obj);
}