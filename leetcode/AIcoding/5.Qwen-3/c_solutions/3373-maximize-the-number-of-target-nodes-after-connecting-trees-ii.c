#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int size;
    int *nodes;
} TreeInfo;

TreeNode* createTreeNode(int val) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

TreeInfo* getTreeInfo(TreeNode* root) {
    TreeInfo* info = (TreeInfo*)malloc(sizeof(TreeInfo));
    info->size = 0;
    info->nodes = NULL;

    if (!root) return info;

    int count = 0;
    TreeNode** queue = (TreeNode**)malloc(sizeof(TreeNode*));
    queue[0] = root;
    count = 1;

    while (count > 0) {
        TreeNode* node = queue[0];
        for (int i = 0; i < count; i++) {
            queue[i] = queue[i + 1];
        }
        count--;

        int* newNodes = (int*)realloc(info->nodes, (info->size + 1) * sizeof(int));
        if (!newNodes) {
            free(info->nodes);
            free(info);
            return NULL;
        }
        newNodes[info->size++] = node->val;
        info->nodes = newNodes;

        if (node->left) {
            TreeNode** newQueue = (TreeNode**)realloc(queue, (count + 1) * sizeof(TreeNode*));
            if (!newQueue) {
                free(queue);
                free(info->nodes);
                free(info);
                return NULL;
            }
            queue = newQueue;
            queue[count++] = node->left;
        }
        if (node->right) {
            TreeNode** newQueue = (TreeNode**)realloc(queue, (count + 1) * sizeof(TreeNode*));
            if (!newQueue) {
                free(queue);
                free(info->nodes);
                free(info);
                return NULL;
            }
            queue = newQueue;
            queue[count++] = node->right;
        }
    }

    free(queue);
    return info;
}

void freeTreeInfo(TreeInfo* info) {
    free(info->nodes);
    free(info);
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int maxTargetNodes(TreeNode* root1, TreeNode* root2, int target) {
    TreeInfo* info1 = getTreeInfo(root1);
    TreeInfo* info2 = getTreeInfo(root2);

    if (!info1 || !info2) return 0;

    qsort(info1->nodes, info1->size, sizeof(int), compare);
    qsort(info2->nodes, info2->size, sizeof(int), compare);

    int count = 0;
    int i = 0, j = info2->size - 1;

    while (i < info1->size && j >= 0) {
        if (info1->nodes[i] + info2->nodes[j] == target) {
            count++;
            i++;
            j--;
        } else if (info1->nodes[i] + info2->nodes[j] < target) {
            i++;
        } else {
            j--;
        }
    }

    freeTreeInfo(info1);
    freeTreeInfo(info2);
    return count;
}