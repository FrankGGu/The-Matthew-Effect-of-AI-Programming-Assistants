#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
  int val;
  struct TreeNode *left;
  struct TreeNode *right;
};

bool isEvenOddTree(struct TreeNode *root) {
  if (!root) return true;

  struct TreeNode **queue = (struct TreeNode **)malloc(sizeof(struct TreeNode *) * 100000);
  int head = 0, tail = 0;
  queue[tail++] = root;
  int level = 0;

  while (head < tail) {
    int size = tail - head;
    int prev = (level % 2 == 0) ? -1 : 1000001;
    for (int i = 0; i < size; i++) {
      struct TreeNode *node = queue[head++];
      if ((level % 2 == 0 && (node->val % 2 == 0 || node->val <= prev)) ||
          (level % 2 != 0 && (node->val % 2 != 0 || node->val >= prev))) {
        free(queue);
        return false;
      }
      prev = node->val;

      if (node->left) queue[tail++] = node->left;
      if (node->right) queue[tail++] = node->right;
    }
    level++;
  }

  free(queue);
  return true;
}