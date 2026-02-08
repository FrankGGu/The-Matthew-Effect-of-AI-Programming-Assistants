/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

typedef struct {
    struct TreeNode** nodes;
    int capacity;
    int size;
} CBTInserter;

CBTInserter* cBTInserterCreate(struct TreeNode* root) {
    CBTInserter* obj = (CBTInserter*)malloc(sizeof(CBTInserter));
    obj->capacity = 10000;
    obj->nodes = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * obj->capacity);
    obj->size = 0;

    struct TreeNode** queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * obj->capacity);
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

int cBTInserterInsert(CBTInserter* obj, int v) {
    struct TreeNode* newNode = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    newNode->val = v;
    newNode->left = NULL;
    newNode->right = NULL;

    obj->nodes[obj->size] = newNode;
    int parentIdx = (obj->size - 1) / 2;
    struct TreeNode* parent = obj->nodes[parentIdx];

    if (parent->left == NULL) {
        parent->left = newNode;
    } else {
        parent->right = newNode;
    }

    obj->size++;
    return parent->val;
}

struct TreeNode* cBTInserterGet_root(CBTInserter* obj) {
    return obj->nodes[0];
}

void cBTInserterFree(CBTInserter* obj) {
    free(obj->nodes);
    free(obj);
}

/**
 * Your CBTInserter struct will be instantiated and called as such:
 * CBTInserter* obj = cBTInserterCreate(root);
 * int param_1 = cBTInserterInsert(obj, v);

 * struct TreeNode* param_2 = cBTInserterGet_root(obj);

 * cBTInserterFree(obj);
*/