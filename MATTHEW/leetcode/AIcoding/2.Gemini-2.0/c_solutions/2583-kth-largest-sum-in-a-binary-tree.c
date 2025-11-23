#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void dfs(struct TreeNode* root, int level, long long* levelSum, int* maxLevel) {
    if (!root) return;

    if (level > *maxLevel) {
        *maxLevel = level;
        levelSum[level] = root->val;
    } else {
        levelSum[level] += root->val;
    }

    dfs(root->left, level + 1, levelSum, maxLevel);
    dfs(root->right, level + 1, levelSum, maxLevel);
}

int cmp(const void* a, const void* b) {
    if (*(long long*)a < *(long long*)b) return 1;
    if (*(long long*)a > *(long long*)b) return -1;
    return 0;
}

long long kthLargestLevelSum(struct TreeNode* root, int k) {
    if (!root) return -1;

    long long levelSum[100001] = {0};
    int maxLevel = 0;
    dfs(root, 1, levelSum, &maxLevel);

    if (maxLevel < k) return -1;

    long long sums[maxLevel];
    for (int i = 0; i < maxLevel; i++) {
        sums[i] = levelSum[i + 1];
    }

    qsort(sums, maxLevel, sizeof(long long), cmp);

    return sums[k - 1];
}