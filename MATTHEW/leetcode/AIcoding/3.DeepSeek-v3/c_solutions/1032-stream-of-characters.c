typedef struct TrieNode {
    struct TrieNode* children[26];
    bool isEnd;
} TrieNode;

typedef struct {
    TrieNode* root;
    char* stream;
    int streamSize;
    int streamCapacity;
} StreamChecker;

TrieNode* createNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    node->isEnd = false;
    return node;
}

void insert(TrieNode* root, char* word) {
    TrieNode* node = root;
    int len = strlen(word);
    for (int i = len - 1; i >= 0; i--) {
        int idx = word[i] - 'a';
        if (!node->children[idx]) {
            node->children[idx] = createNode();
        }
        node = node->children[idx];
    }
    node->isEnd = true;
}

StreamChecker* streamCheckerCreate(char** words, int wordsSize) {
    StreamChecker* obj = (StreamChecker*)malloc(sizeof(StreamChecker));
    obj->root = createNode();
    obj->streamCapacity = 40000;
    obj->stream = (char*)malloc(obj->streamCapacity * sizeof(char));
    obj->streamSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        insert(obj->root, words[i]);
    }

    return obj;
}

bool streamCheckerQuery(StreamChecker* obj, char letter) {
    if (obj->streamSize >= obj->streamCapacity) {
        obj->streamCapacity *= 2;
        obj->stream = (char*)realloc(obj->stream, obj->streamCapacity * sizeof(char));
    }
    obj->stream[obj->streamSize++] = letter;

    TrieNode* node = obj->root;
    for (int i = obj->streamSize - 1; i >= 0; i--) {
        int idx = obj->stream[i] - 'a';
        if (!node->children[idx]) {
            return false;
        }
        node = node->children[idx];
        if (node->isEnd) {
            return true;
        }
    }
    return false;
}

void streamCheckerFree(StreamChecker* obj) {
    free(obj->stream);

    // Free trie nodes (using DFS)
    TrieNode* nodes[40000];
    int top = 0;
    nodes[top++] = obj->root;

    while (top > 0) {
        TrieNode* node = nodes[--top];
        for (int i = 0; i < 26; i++) {
            if (node->children[i]) {
                nodes[top++] = node->children[i];
            }
        }
        free(node);
    }

    free(obj);
}

/**
 * Your StreamChecker struct will be instantiated and called as such:
 * StreamChecker* obj = streamCheckerCreate(words, wordsSize);
 * bool param_1 = streamCheckerQuery(obj, letter);

 * streamCheckerFree(obj);
*/