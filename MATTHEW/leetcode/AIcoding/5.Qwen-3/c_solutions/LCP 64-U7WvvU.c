#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int size;
    int capacity;
    TreeNode **data;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->size = 0;
    q->capacity = capacity;
    q->data = (TreeNode**)malloc(capacity * sizeof(TreeNode*));
    return q;
}

void enqueue(Queue* q, TreeNode* node) {
    if (q->size < q->capacity) {
        q->data[q->size++] = node;
    }
}

TreeNode* dequeue(Queue* q) {
    if (q->size > 0) {
        return q->data[--q->size];
    }
    return NULL;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

int amountOfTime(struct TreeNode* root, int start) {
    int result = 0;
    Queue* queue = createQueue(10000);
    TreeNode* dummy = (TreeNode*)malloc(sizeof(TreeNode));
    dummy->val = -1;
    dummy->left = NULL;
    dummy->right = NULL;
    TreeNode* parent = dummy;
    int found = 0;

    void dfs(struct TreeNode* node, struct TreeNode* p) {
        if (!node) return;
        node->val = node->val;
        if (node->val == start) {
            found = 1;
            parent = p;
        }
        dfs(node->left, node);
        dfs(node->right, node);
    }

    dfs(root, parent);

    if (!found) {
        freeQueue(queue);
        free(dummy);
        return 0;
    }

    int depth = 0;
    queue = createQueue(10000);
    enqueue(queue, parent);
    while (!isEmpty(queue)) {
        int levelSize = queue->size;
        for (int i = 0; i < levelSize; i++) {
            TreeNode* node = dequeue(queue);
            if (node->left && node->left->val != -1) enqueue(queue, node->left);
            if (node->right && node->right->val != -1) enqueue(queue, node->right);
        }
        depth++;
    }

    freeQueue(queue);
    free(dummy);
    return depth - 1;
}