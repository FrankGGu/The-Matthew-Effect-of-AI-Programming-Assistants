struct TreeNode** nodes;
int nodeCount;

void inorder(struct TreeNode* root) {
    if (!root) return;
    inorder(root->left);
    nodes[nodeCount++] = root;
    inorder(root->right);
}

struct TreeNode* buildBST(int start, int end) {
    if (start > end) return NULL;
    int mid = (start + end) / 2;
    struct TreeNode* node = nodes[mid];
    node->left = buildBST(start, mid - 1);
    node->right = buildBST(mid + 1, end);
    return node;
}

struct TreeNode* balanceBST(struct TreeNode* root) {
    nodeCount = 0;
    nodes = (struct TreeNode**)malloc(10000 * sizeof(struct TreeNode*));
    inorder(root);
    return buildBST(0, nodeCount - 1);
}