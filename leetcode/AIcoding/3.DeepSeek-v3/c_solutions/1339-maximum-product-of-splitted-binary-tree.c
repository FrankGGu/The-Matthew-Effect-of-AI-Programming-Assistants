#include <stdlib.h>
#include <limits.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

long long totalSum = 0;
long long maxProduct = 0;

long long calculateSum(struct TreeNode* node) {
    if (node == NULL) return 0;
    long long leftSum = calculateSum(node->left);
    long long rightSum = calculateSum(node->right);
    return leftSum + rightSum + node->val;
}

long long findMaxProduct(struct TreeNode* node) {
    if (node == NULL) return 0;
    long long leftSum = findMaxProduct(node->left);
    long long rightSum = findMaxProduct(node->right);
    long long subtreeSum = leftSum + rightSum + node->val;
    long long product = subtreeSum * (totalSum - subtreeSum);
    if (product > maxProduct) {
        maxProduct = product;
    }
    return subtreeSum;
}

int maxProductSplit(struct TreeNode* root) {
    totalSum = calculateSum(root);
    maxProduct = 0;
    findMaxProduct(root);
    return maxProduct % 1000000007;
}

int maxProduct(struct TreeNode* root){
    return maxProductSplit(root);
}