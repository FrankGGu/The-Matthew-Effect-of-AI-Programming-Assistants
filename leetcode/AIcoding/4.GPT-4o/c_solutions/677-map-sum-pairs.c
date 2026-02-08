typedef struct {
    struct TreeNode* left;
    struct TreeNode* right;
    char* key;
    int value;
} TreeNode;

typedef struct {
    TreeNode* root;
} MapSum;

TreeNode* insert(TreeNode* node, char* key, int value, int index) {
    if (node == NULL) {
        node = malloc(sizeof(TreeNode));
        node->left = node->right = NULL;
        node->key = NULL;
        node->value = 0;
    }
    if (index == strlen(key)) {
        if (node->key == NULL) {
            node->key = strdup(key);
        }
        node->value = value;
    } else {
        if (key[index] < 'a' || key[index] > 'z') return node;
        if (key[index] == 'a') {
            node->left = insert(node->left, key, value, index + 1);
        } else {
            node->right = insert(node->right, key, value, index + 1);
        }
    }
    return node;
}

int sum(TreeNode* node, char* prefix, int index) {
    if (node == NULL) return 0;
    if (index == strlen(prefix)) {
        return node->value + sum(node->left, prefix, index) + sum(node->right, prefix, index);
    }
    if (prefix[index] == 'a') {
        return sum(node->left, prefix, index + 1);
    } else {
        return sum(node->right, prefix, index + 1);
    }
}

MapSum* mapSumCreate() {
    MapSum* obj = malloc(sizeof(MapSum));
    obj->root = NULL;
    return obj;
}

void mapSumInsert(MapSum* obj, char* key, int val) {
    obj->root = insert(obj->root, key, val, 0);
}

int mapSumSum(MapSum* obj, char* prefix) {
    return sum(obj->root, prefix, 0);
}

void mapSumFree(MapSum* obj) {
    // Free memory for each node (omitted for brevity)
    free(obj);
}