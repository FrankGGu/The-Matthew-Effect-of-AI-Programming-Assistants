#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct Node {
    int val;
    struct Node* left;
    struct Node* right;
} TreeNode;

typedef struct {
    int size;
    TreeNode** data;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->size = 0;
    q->data = (TreeNode**)malloc(capacity * sizeof(TreeNode*));
    return q;
}

void enqueue(Queue* q, TreeNode* node) {
    q->data[q->size++] = node;
}

TreeNode* dequeue(Queue* q) {
    TreeNode* node = q->data[0];
    for (int i = 0; i < q->size - 1; i++) {
        q->data[i] = q->data[i + 1];
    }
    q->size--;
    return node;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

TreeNode* newNode(int val) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

int maxDepth(TreeNode* root) {
    if (!root) return 0;
    int left = maxDepth(root->left);
    int right = maxDepth(root->right);
    return 1 + (left > right ? left : right);
}

TreeNode* insertIntoBST(TreeNode* root, int val) {
    if (!root) return newNode(val);
    if (val < root->val) {
        root->left = insertIntoBST(root->left, val);
    } else {
        root->right = insertIntoBST(root->right, val);
    }
    return root;
}

TreeNode* deleteNode(TreeNode* root, int key) {
    if (!root) return NULL;
    if (key < root->val) {
        root->left = deleteNode(root->left, key);
    } else if (key > root->val) {
        root->right = deleteNode(root->right, key);
    } else {
        if (!root->left) {
            TreeNode* temp = root->right;
            free(root);
            return temp;
        } else if (!root->right) {
            TreeNode* temp = root->left;
            free(root);
            return temp;
        }
        TreeNode* temp = root->right;
        while (temp->left) {
            temp = temp->left;
        }
        root->val = temp->val;
        root->right = deleteNode(root->right, temp->val);
    }
    return root;
}

int findBottomLeftValue(TreeNode* root) {
    if (!root) return 0;
    Queue* q = createQueue(1000);
    enqueue(q, root);
    int result = root->val;
    while (!isEmpty(q)) {
        int levelSize = q->size;
        for (int i = 0; i < levelSize; i++) {
            TreeNode* node = dequeue(q);
            if (i == 0) {
                result = node->val;
            }
            if (node->left) enqueue(q, node->left);
            if (node->right) enqueue(q, node->right);
        }
    }
    freeQueue(q);
    return result;
}

int countNodes(TreeNode* root) {
    if (!root) return 0;
    return 1 + countNodes(root->left) + countNodes(root->right);
}

TreeNode* buildTree(int* nums, int numsSize) {
    if (numsSize == 0) return NULL;
    TreeNode* root = newNode(nums[0]);
    for (int i = 1; i < numsSize; i++) {
        insertIntoBST(root, nums[i]);
    }
    return root;
}

void freeTree(TreeNode* root) {
    if (!root) return;
    freeTree(root->left);
    freeTree(root->right);
    free(root);
}