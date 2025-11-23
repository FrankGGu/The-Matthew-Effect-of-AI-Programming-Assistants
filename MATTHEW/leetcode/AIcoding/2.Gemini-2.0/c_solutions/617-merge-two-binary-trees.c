#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode* mergeTrees(struct TreeNode* root1, struct TreeNode* root2){
    if (!root1) return root2;
    if (!root2) return root1;

    struct TreeNode* merged = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    merged->val = root1->val + root2->val;
    merged->left = mergeTrees(root1->left, root2->left);
    merged->right = mergeTrees(root1->right, root2->right);

    return merged;
}