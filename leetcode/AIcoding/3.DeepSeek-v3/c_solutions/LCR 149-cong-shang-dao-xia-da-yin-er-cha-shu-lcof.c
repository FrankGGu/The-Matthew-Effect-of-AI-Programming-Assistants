/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */
/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* decorateRecord(struct TreeNode* root, int* returnSize) {
    if (root == NULL) {
        *returnSize = 0;
        return NULL;
    }

    struct TreeNode* queue[1000];
    int front = 0, rear = 0;
    int* res = (int*)malloc(1000 * sizeof(int));
    *returnSize = 0;

    queue[rear++] = root;

    while (front < rear) {
        struct TreeNode* node = queue[front++];
        res[(*returnSize)++] = node->val;

        if (node->left != NULL) {
            queue[rear++] = node->left;
        }
        if (node->right != NULL) {
            queue[rear++] = node->right;
        }
    }

    return res;
}