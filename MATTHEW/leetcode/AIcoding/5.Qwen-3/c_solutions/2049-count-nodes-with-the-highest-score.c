#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int count;
    int maxScore;
} Result;

int dfs(TreeNode* root, int* result) {
    if (!root) return 0;

    int left = dfs(root->left, result);
    int right = dfs(root->root->right, result);

    int score = 1;
    if (left > 0) score *= left;
    if (right > 0) score *= right;

    if (score > result[0]) {
        result[0] = score;
        result[1] = 1;
    } else if (score == result[0]) {
        result[1]++;
    }

    return left + right + 1;
}

int countHighestScoreNodes(struct TreeNode* root) {
    int result[2] = {0, 0};
    dfs(root, result);
    return result[1];
}