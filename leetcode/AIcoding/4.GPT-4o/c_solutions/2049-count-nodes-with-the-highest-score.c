#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void countNodes(struct TreeNode* root, long long* count, long long* maxScore, long long totalNodes) {
    if (!root) return;

    long long leftCount = 0, rightCount = 0;
    countNodes(root->left, &leftCount, maxScore, totalNodes);
    countNodes(root->right, &rightCount, maxScore, totalNodes);

    long long currentScore = (leftCount + 1) * (rightCount + 1) * (totalNodes - leftCount - rightCount - 1);
    if (currentScore > *maxScore) {
        *maxScore = currentScore;
        *count = 1;
    } else if (currentScore == *maxScore) {
        (*count)++;
    }
}

int countHighestScoreNodes(struct TreeNode* root) {
    long long totalNodes = 0;
    struct TreeNode* temp = root;
    while (temp) {
        totalNodes++;
        temp = temp->left ? temp->left : temp->right;
    }

    long long count = 0, maxScore = 0;
    countNodes(root, &count, &maxScore, totalNodes);
    return count;
}