typedef struct TrieNode {
    int val;
    struct TrieNode* children[26];
} TrieNode;

typedef struct {
    TrieNode* root;
} MapSum;

TrieNode* trieNodeCreate() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->val = 0;
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    return node;
}

MapSum* mapSumCreate() {
    MapSum* obj = (MapSum*)malloc(sizeof(MapSum));
    obj->root = trieNodeCreate();
    return obj;
}

void mapSumInsert(MapSum* obj, char* key, int val) {
    TrieNode* node = obj->root;
    for (int i = 0; key[i]; i++) {
        int idx = key[i] - 'a';
        if (!node->children[idx]) {
            node->children[idx] = trieNodeCreate();
        }
        node = node->children[idx];
    }
    node->val = val;
}

int dfs(TrieNode* node) {
    if (!node) return 0;
    int sum = node->val;
    for (int i = 0; i < 26; i++) {
        if (node->children[i]) {
            sum += dfs(node->children[i]);
        }
    }
    return sum;
}

int mapSumSum(MapSum* obj, char* prefix) {
    TrieNode* node = obj->root;
    for (int i = 0; prefix[i]; i++) {
        int idx = prefix[i] - 'a';
        if (!node->children[idx]) {
            return 0;
        }
        node = node->children[idx];
    }
    return dfs(node);
}

void mapSumFree(MapSum* obj) {
    if (!obj) return;

    TrieNode* nodes[1000];
    int front = 0, rear = 0;
    nodes[rear++] = obj->root;

    while (front < rear) {
        TrieNode* node = nodes[front++];
        for (int i = 0; i < 26; i++) {
            if (node->children[i]) {
                nodes[rear++] = node->children[i];
            }
        }
        free(node);
    }
    free(obj);
}