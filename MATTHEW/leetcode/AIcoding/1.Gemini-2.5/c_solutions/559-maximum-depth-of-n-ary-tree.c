int maxDepth(struct Node* root) {
    if (root == NULL) {
        return 0;
    }

    if (root->numChildren == 0) {
        return 1;
    }

    int maxChildDepth = 0;
    for (int i = 0; i < root->numChildren; i++) {
        int currentChildDepth = maxDepth(root->children[i]);
        if (currentChildDepth > maxChildDepth) {
            maxChildDepth = currentChildDepth;
        }
    }

    return 1 + maxChildDepth;
}