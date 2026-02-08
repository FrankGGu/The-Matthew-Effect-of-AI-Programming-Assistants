int pathSum(struct TreeNode* root, int targetSum) {
    if (!root) return 0;

    int count = 0;
    struct TreeNode* stack[1000];
    int top = -1;
    struct TreeNode* node = root;

    while (node || top != -1) {
        while (node) {
            stack[++top] = node;
            node = node->left;
        }
        node = stack[top--];

        // Check paths starting from this node
        struct TreeNode* pathStack[1000];
        int pathTop = -1;
        long long currentSum = 0;
        struct TreeNode* temp = node;

        while (temp) {
            currentSum += temp->val;
            if (currentSum == targetSum) {
                count++;
            }

            // Move to parent
            if (temp->left && pathTop != -1 && pathStack[pathTop] == temp->left) {
                temp = temp->right;
            } else if (temp->right && pathTop != -1 && pathStack[pathTop] == temp->right) {
                pathTop--;
                temp = temp->left;
            } else {
                pathStack[++pathTop] = temp;
                temp = temp->left;
                if (!temp && pathTop != -1) {
                    temp = pathStack[pathTop]->right;
                }
            }
        }

        node = node->right;
    }

    return count;
}