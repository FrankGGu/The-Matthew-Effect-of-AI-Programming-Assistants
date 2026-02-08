#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct TreeNode TreeNode;

int* levelOrder(TreeNode* root, int* returnSize);
int minOperationsToSortBinaryTreeByLevel(TreeNode* root);

int* levelOrder(TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    int* result = NULL;
    int size = 0;
    int capacity = 1;
    result = (int*)malloc(capacity * sizeof(int));

    TreeNode** queue = (TreeNode**)malloc(sizeof(TreeNode*));
    queue[0] = root;
    int front = 0;
    int rear = 1;

    while (front < rear) {
        int levelSize = rear - front;
        for (int i = 0; i < levelSize; i++) {
            TreeNode* node = queue[front + i];
            result[size++] = node->val;
            if (size == capacity) {
                capacity *= 2;
                result = (int*)realloc(result, capacity * sizeof(int));
            }
            if (node->left) {
                queue = (TreeNode**)realloc(queue, (rear + 1) * sizeof(TreeNode*));
                queue[rear++] = node->left;
            }
            if (node->right) {
                queue = (TreeNode**)realloc(queue, (rear + 1) * sizeof(TreeNode*));
                queue[rear++] = node->right;
            }
        }
        front += levelSize;
    }

    free(queue);
    *returnSize = size;
    return result;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int minOperationsToSortBinaryTreeByLevel(TreeNode* root) {
    int levelSize;
    int* levels = levelOrder(root, &levelSize);
    if (!levels || levelSize == 0) return 0;

    int* sorted = (int*)malloc(levelSize * sizeof(int));
    for (int i = 0; i < levelSize; i++) {
        sorted[i] = levels[i];
    }
    qsort(sorted, levelSize, sizeof(int), compare);

    int operations = 0;
    int* indices = (int*)malloc(levelSize * sizeof(int));
    for (int i = 0; i < levelSize; i++) {
        indices[i] = i;
    }

    for (int i = 0; i < levelSize; i++) {
        int j = i;
        while (j < levelSize && sorted[j] != levels[i]) {
            j++;
        }
        if (j < levelSize) {
            int temp = indices[i];
            indices[i] = indices[j];
            indices[j] = temp;
            operations++;
        }
    }

    free(levels);
    free(sorted);
    free(indices);
    return operations;
}