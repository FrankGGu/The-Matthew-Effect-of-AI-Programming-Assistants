/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

int minOperations(struct TreeNode* root) {
    if (root == NULL) return 0;

    struct TreeNode* queue[10000];
    int front = 0, rear = 0;
    queue[rear++] = root;

    int result = 0;

    while (front < rear) {
        int levelSize = rear - front;
        int levelSum = 0;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            levelSum += node->val;

            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }

        if (levelSize > 0) {
            if (levelSum == 0) {
                result++;
            } else if (levelSum < levelSize) {
                result += levelSum;
            } else {
                result += (levelSize - levelSum % levelSize);
            }
        }
    }

    return result;
}