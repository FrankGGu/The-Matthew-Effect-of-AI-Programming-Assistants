#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int countPossibleRoots(int* nums, int numsSize, int* leftChild, int leftChildSize, int* rightChild, int rightChildSize) {
    int* visited = (int*)calloc(numsSize, sizeof(int));
    int* childCount = (int*)calloc(numsSize, sizeof(int));
    int* parent = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        parent[i] = -1;
    }

    for (int i = 0; i < leftChildSize; i++) {
        if (leftChild[i] != -1) {
            int idx = -1;
            for (int j = 0; j < numsSize; j++) {
                if (nums[j] == leftChild[i]) {
                    idx = j;
                    break;
                }
            }
            if (idx != -1) {
                parent[idx] = i;
                childCount[i]++;
            }
        }
    }

    for (int i = 0; i < rightChildSize; i++) {
        if (rightChild[i] != -1) {
            int idx = -1;
            for (int j = 0; j < numsSize; j++) {
                if (nums[j] == rightChild[i]) {
                    idx = j;
                    break;
                }
            }
            if (idx != -1) {
                parent[idx] = i;
                childCount[i]++;
            }
        }
    }

    int rootCount = 0;
    for (int i = 0; i < numsSize; i++) {
        if (parent[i] == -1 && childCount[i] <= 2) {
            rootCount++;
        }
    }

    free(visited);
    free(childCount);
    free(parent);
    return rootCount;
}

TreeNode* buildTree(int* nums, int numsSize, int* leftChild, int leftChildSize, int* rightChild, int rightChildSize) {
    TreeNode** nodes = (TreeNode**)malloc(numsSize * sizeof(TreeNode*));
    for (int i = 0; i < numsSize; i++) {
        nodes[i] = (TreeNode*)malloc(sizeof(TreeNode));
        nodes[i]->val = nums[i];
        nodes[i]->left = NULL;
        nodes[i]->right = NULL;
    }

    for (int i = 0; i < leftChildSize; i++) {
        if (leftChild[i] != -1) {
            int idx = -1;
            for (int j = 0; j < numsSize; j++) {
                if (nums[j] == leftChild[i]) {
                    idx = j;
                    break;
                }
            }
            if (idx != -1) {
                nodes[i]->left = nodes[idx];
            }
        }
    }

    for (int i = 0; i < rightChildSize; i++) {
        if (rightChild[i] != -1) {
            int idx = -1;
            for (int j = 0; j < numsSize; j++) {
                if (nums[j] == rightChild[i]) {
                    idx = j;
                    break;
                }
            }
            if (idx != -1) {
                nodes[i]->right = nodes[idx];
            }
        }
    }

    return nodes[0];
}

int countNodes(TreeNode* root) {
    if (root == NULL) return 0;
    return 1 + countNodes(root->left) + countNodes(root->right);
}

int countPossibleRoots(int* nums, int numsSize, int* leftChild, int leftChildSize, int* rightChild, int rightChildSize) {
    TreeNode* root = buildTree(nums, numsSize, leftChild, leftChildSize, rightChild, rightChildSize);
    int totalNodes = countNodes(root);
    return totalNodes;
}