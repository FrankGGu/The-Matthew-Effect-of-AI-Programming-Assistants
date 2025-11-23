#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
  int val;
  struct TreeNode *left;
  struct TreeNode *right;
};

int max(int a, int b) { return (a > b) ? a : b; }

int dfs(struct TreeNode *root, int *max_sum) {
  if (!root) {
    return 0;
  }

  int left_sum = dfs(root->left, max_sum);
  int right_sum = dfs(root->right, max_sum);

  int include_root = root->val + (left_sum > 0 ? left_sum : 0) +
                       (right_sum > 0 ? right_sum : 0);
  *max_sum = max(*max_sum, include_root);

  int exclude_root = max(0, max(left_sum, right_sum));

  return root->val + max(0, max(left_sum, right_sum));
}

int maxPathSum(struct TreeNode *root) {
  int max_sum = root->val;
  dfs(root, &max_sum);
  return max_sum;
}