#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    TreeNode *root;
    TreeNode **queue;
    int front;
    int rear;
    int size;
} CBTInserter;

CBTInserter* cbtCreate(struct TreeNode* root) {
    CBTInserter* obj = (CBTInserter*)malloc(sizeof(CBTInserter));
    obj->root = root;
    obj->size = 0;
    obj->front = 0;
    obj->rear = 0;
    obj->queue = (TreeNode**)malloc(sizeof(TreeNode*) * 1000);

    if (root == NULL) return obj;

    TreeNode* temp = root;
    obj->queue[obj->rear++] = temp;
    obj->size++;

    while (obj->front < obj->rear) {
        temp = obj->queue[obj->front];
        if (temp->left) {
            obj->queue[obj->rear++] = temp->left;
            obj->size++;
        }
        if (temp->right) {
            obj->queue[obj->rear++] = temp->right;
            obj->size++;
        }
        obj->front++;
    }

    return obj;
}

int cbtInsert(CBTInserter* obj, int val) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;

    obj->queue[obj->rear++] = node;
    obj->size++;

    TreeNode* parent = obj->queue[(obj->rear - 1 - 1) / 2];

    if (!parent->left) {
        parent->left = node;
    } else {
        parent->right = node;
    }

    return parent->val;
}

void cbtFree(CBTInserter* obj) {
    free(obj->queue);
    free(obj);
}