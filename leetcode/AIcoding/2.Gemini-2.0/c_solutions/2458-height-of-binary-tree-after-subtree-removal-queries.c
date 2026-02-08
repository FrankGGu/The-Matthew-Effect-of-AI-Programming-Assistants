#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int getHeight(struct TreeNode* root) {
    if (root == NULL) {
        return -1;
    }
    int leftHeight = getHeight(root->left);
    int rightHeight = getHeight(root->right);
    return (leftHeight > rightHeight ? leftHeight : rightHeight) + 1;
}

void getHeights(struct TreeNode* root, int height, int* heights, int* maxHeights, int* secondMaxHeights) {
    if (root == NULL) {
        return;
    }
    heights[root->val] = height;
    if (height > *maxHeights) {
        *secondMaxHeights = *maxHeights;
        *maxHeights = height;
    } else if (height > *secondMaxHeights && height != *maxHeights) {
        *secondMaxHeights = height;
    }
    getHeights(root->left, height + 1, heights, maxHeights, secondMaxHeights);
    getHeights(root->right, height + 1, heights, maxHeights, secondMaxHeights);
}

int* treeQueries(struct TreeNode* root, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int maxVal = 0;
    int queueSize = 0;
    struct TreeNode** queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * 100001);
    int front = 0, rear = 0;
    queue[rear++] = root;
    queueSize++;
    while (front < rear) {
        struct TreeNode* node = queue[front++];
        queueSize--;
        if (node->val > maxVal) {
            maxVal = node->val;
        }
        if (node->left) {
            queue[rear++] = node->left;
            queueSize++;
        }
        if (node->right) {
            queue[rear++] = node->right;
            queueSize++;
        }
    }
    free(queue);

    int* heights = (int*)malloc(sizeof(int) * (maxVal + 1));
    int maxHeight = -1;
    int secondMaxHeight = -1;
    getHeights(root, 0, heights, &maxHeight, &secondMaxHeight);

    int* result = (int*)malloc(sizeof(int) * queriesSize);
    for (int i = 0; i < queriesSize; i++) {
        int queryVal = queries[i][0];
        if (heights[queryVal] == maxHeight) {
            result[i] = secondMaxHeight;
        } else {
            result[i] = maxHeight;
        }
    }

    free(heights);
    *returnSize = queriesSize;
    return result;
}