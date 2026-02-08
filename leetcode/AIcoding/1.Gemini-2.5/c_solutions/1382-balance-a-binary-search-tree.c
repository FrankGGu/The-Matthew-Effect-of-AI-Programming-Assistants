void inorder_collect_nodes(struct TreeNode* root, struct TreeNode*** nodes_ptr, int* count_ptr, int* capacity_ptr) {
    if (root == NULL) {
        return;
    }

    inorder_collect_nodes(root->left, nodes_ptr, count_ptr, capacity_ptr);

    if (*count_ptr == *capacity_ptr) {
        *capacity_ptr = (*capacity_ptr == 0) ? 1 : (*capacity_ptr) * 2;
        *nodes_ptr = (struct TreeNode**)realloc(*nodes_ptr, (*capacity_ptr) * sizeof(struct TreeNode*));
    }
    (*nodes_ptr)[(*count_ptr)++] = root;

    inorder_collect_nodes(root->right, nodes_ptr, count_ptr, capacity_ptr);
}

struct TreeNode* build_balanced_bst_from_array(struct TreeNode** nodes, int start, int end) {
    if (start > end) {
        return NULL;
    }

    int mid = start + (end - start) / 2;
    struct TreeNode* root = nodes[mid];
    root->left = build_balanced_bst_from_array(nodes, start, mid - 1);
    root->right = build_balanced_bst_from_array(nodes, mid + 1, end);
    return root;
}

struct TreeNode* balanceBST(struct TreeNode* root) {
    if (root == NULL) {
        return NULL;
    }

    struct TreeNode** nodes_array = NULL;
    int nodes_count = 0;
    int nodes_capacity = 0;

    inorder_collect_nodes(root, &nodes_array, &nodes_count, &nodes_capacity);

    struct TreeNode* balanced_root = build_balanced_bst_from_array(nodes_array, 0, nodes_count - 1);

    free(nodes_array);

    return balanced_root;
}