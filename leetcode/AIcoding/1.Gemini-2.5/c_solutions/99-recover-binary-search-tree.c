struct TreeNode *firstNode = NULL;
struct TreeNode *secondNode = NULL;
struct TreeNode *prevNode = NULL;

void inorderTraversal(struct TreeNode* root) {
    if (root == NULL) {
        return;
    }

    inorderTraversal(root->left);

    if (prevNode != NULL && root->val < prevNode->val) {
        if (firstNode == NULL) {
            firstNode = prevNode;
        }
        secondNode = root;
    }
    prevNode = root;

    inorderTraversal(root->right);
}

void recoverTree(struct TreeNode* root) {
    firstNode = NULL;
    secondNode = NULL;
    prevNode = NULL;

    inorderTraversal(root);

    if (firstNode != NULL && secondNode != NULL) {
        int temp = firstNode->val;
        firstNode->val = secondNode->val;
        secondNode->val = temp;
    }
}