struct CBTInserter {
    struct TreeNode **nodes;
    int size;
};

struct CBTInserter* cBTInserterCreate(struct TreeNode* root) {
    struct CBTInserter* obj = (struct CBTInserter*)malloc(sizeof(struct CBTInserter));
    obj->nodes = (struct TreeNode**)malloc(1000 * sizeof(struct TreeNode*));
    obj->size = 0;
    struct TreeNode** queue = (struct TreeNode**)malloc(1000 * sizeof(struct TreeNode*));
    int front = 0, rear = 0;
    queue[rear++] = root;

    while (front < rear) {
        struct TreeNode* node = queue[front++];
        obj->nodes[obj->size++] = node;
        if (node->left) queue[rear++] = node->left;
        if (node->right) queue[rear++] = node->right;
    }

    free(queue);
    return obj;
}

int cBTInserterInsert(struct CBTInserter* obj, int v) {
    struct TreeNode* newNode = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    newNode->val = v;
    newNode->left = newNode->right = NULL;

    struct TreeNode* parent = obj->nodes[(obj->size - 1) / 2];
    if (!parent->left) {
        parent->left = newNode;
    } else {
        parent->right = newNode;
    }

    obj->nodes[obj->size++] = newNode;
    return parent->val;
}

struct TreeNode* cBTInserterGetRoot(struct CBTInserter* obj) {
    return obj->nodes[0];
}

void cBTInserterFree(struct CBTInserter* obj) {
    free(obj->nodes);
    free(obj);
}