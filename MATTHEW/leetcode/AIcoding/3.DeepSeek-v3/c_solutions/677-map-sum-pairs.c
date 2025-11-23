typedef struct TrieNode {
    int val;
    int sum;
    struct TrieNode* children[26];
} TrieNode;

typedef struct {
    TrieNode* root;
} MapSum;

MapSum* mapSumCreate() {
    MapSum* obj = (MapSum*)malloc(sizeof(MapSum));
    obj->root = (TrieNode*)calloc(1, sizeof(TrieNode));
    return obj;
}

void mapSumInsert(MapSum* obj, char* key, int val) {
    TrieNode* node = obj->root;
    int oldVal = 0;
    TrieNode* temp = obj->root;

    for (int i = 0; key[i]; i++) {
        int idx = key[i] - 'a';
        if (!temp->children[idx]) {
            break;
        }
        temp = temp->children[idx];
        if (i == strlen(key) - 1) {
            oldVal = temp->val;
        }
    }

    for (int i = 0; key[i]; i++) {
        int idx = key[i] - 'a';
        if (!node->children[idx]) {
            node->children[idx] = (TrieNode*)calloc(1, sizeof(TrieNode));
        }
        node = node->children[idx];
        node->sum += val - oldVal;
    }
    node->val = val;
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
    return node->sum;
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