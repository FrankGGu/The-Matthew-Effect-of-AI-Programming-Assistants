#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int val;
    struct Node* left;
    struct Node* right;
} Node;

int minScore(Node* root, int* minScore) {
    if (!root) return 0;
    int left = minScore(root->left, minScore);
    int right = minScore(root->right, minScore);
    int score = root->val - left - right;
    if (score < *minScore) *minScore = score;
    return score > 0 ? score : 0;
}

int minimumScore(Node* root) {
    int minScoreValue = INT_MAX;
    minScore(root, &minScoreValue);
    return minScoreValue;
}