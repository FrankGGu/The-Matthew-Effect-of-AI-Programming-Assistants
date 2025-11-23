/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

bool isEvenOddTree(struct TreeNode* root) {
    if (!root) return true;

    struct TreeNode* queue[100000];
    int front = 0, rear = 0;
    queue[rear++] = root;
    int level = 0;

    while (front < rear) {
        int levelSize = rear - front;
        int prevVal = (level % 2 == 0) ? INT_MIN : INT_MAX;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];

            if (level % 2 == 0) {
                if (node->val % 2 == 0 || node->val <= prevVal) {
                    return false;
                }
            } else {
                if (node->val % 2 == 1 || node->val >= prevVal) {
                    return false;
                }
            }
            prevVal = node->val;

            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }
        level++;
    }

    return true;
}