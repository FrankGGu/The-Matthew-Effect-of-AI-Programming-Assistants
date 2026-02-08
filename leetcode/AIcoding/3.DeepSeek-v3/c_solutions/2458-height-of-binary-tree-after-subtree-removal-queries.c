/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

#define MAX_NODES 100001

typedef struct {
    int depth;
    int height;
} NodeInfo;

NodeInfo info[MAX_NODES];
int maxHeightAtDepth[MAX_NODES];
int secondMaxHeightAtDepth[MAX_NODES];

void dfs(struct TreeNode* node, int depth) {
    if (!node) return;

    info[node->val].depth = depth;

    int leftHeight = 0, rightHeight = 0;
    if (node->left) {
        dfs(node->left, depth + 1);
        leftHeight = info[node->left->val].height + 1;
    }
    if (node->right) {
        dfs(node->right, depth + 1);
        rightHeight = info[node->right->val].height + 1;
    }

    info[node->val].height = (leftHeight > rightHeight) ? leftHeight : rightHeight;

    if (info[node->val].height > maxHeightAtDepth[depth]) {
        secondMaxHeightAtDepth[depth] = maxHeightAtDepth[depth];
        maxHeightAtDepth[depth] = info[node->val].height;
    } else if (info[node->val].height > secondMaxHeightAtDepth[depth]) {
        secondMaxHeightAtDepth[depth] = info[node->val].height;
    }
}

int* treeQueries(struct TreeNode* root, int* queries, int queriesSize, int* returnSize) {
    for (int i = 0; i < MAX_NODES; i++) {
        maxHeightAtDepth[i] = 0;
        secondMaxHeightAtDepth[i] = 0;
    }

    dfs(root, 0);

    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int nodeVal = queries[i];
        int depth = info[nodeVal].depth;
        int height = info[nodeVal].height;

        if (height == maxHeightAtDepth[depth]) {
            result[i] = depth + secondMaxHeightAtDepth[depth];
        } else {
            result[i] = depth + maxHeightAtDepth[depth];
        }
    }

    return result;
}