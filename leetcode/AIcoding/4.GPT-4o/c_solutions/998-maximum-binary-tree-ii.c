struct TreeNode* insertIntoMaxTree(struct TreeNode* root, int val) {
    struct TreeNode* newNode = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    newNode->val = val;
    newNode->left = NULL;
    newNode->right = NULL;

    if (!root || val > root->val) {
        newNode->left = root;
        return newNode;
    }

    struct TreeNode* curr = root;
    while (curr) {
        if (val > curr->val) {
            newNode->left = curr;
            return newNode;
        }
        if (!curr->right) {
            curr->right = newNode;
            return root;
        }
        curr = curr->right;
    }

    return root;
}