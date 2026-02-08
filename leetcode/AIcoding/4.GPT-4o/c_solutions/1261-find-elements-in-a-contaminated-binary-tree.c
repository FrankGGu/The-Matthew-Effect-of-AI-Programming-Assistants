struct FindElements {
    struct Node* root;
    bool* found;
    int size;

    void dfs(struct Node* node, int val) {
        if (!node) return;
        node->val = val;
        if (val >= size) {
            size = val + 1;
            found = realloc(found, size * sizeof(bool));
            memset(found + size - 1, 0, sizeof(bool));
        }
        found[val] = true;
        dfs(node->left, 2 * val + 1);
        dfs(node->right, 2 * val + 2);
    }
};

struct FindElements* findElementsCreate(struct Node* root) {
    struct FindElements* obj = malloc(sizeof(struct FindElements));
    obj->root = root;
    obj->found = NULL;
    obj->size = 0;
    dfs(root, 0);
    return obj;
}

bool findElementsFind(struct FindElements* obj, int target) {
    if (target >= obj->size) return false;
    return obj->found[target];
}

void findElementsFree(struct FindElements* obj) {
    free(obj->found);
    free(obj);
}