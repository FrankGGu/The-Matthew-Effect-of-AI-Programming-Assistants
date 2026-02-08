typedef struct {
    int **ret;
    int *colSizes;
    int returnSize;
} Result;

void traverse(struct TreeNode* node, int level, Result *res) {
    if (!node) return;

    if (level >= res->returnSize) {
        res->ret = realloc(res->ret, (level + 1) * sizeof(int*));
        res->colSizes = realloc(res->colSizes, (level + 1) * sizeof(int));
        res->ret[level] = NULL;
        res->colSizes[level] = 0;
        res->returnSize = level + 1;
    }

    res->colSizes[level]++;
    res->ret[level] = realloc(res->ret[level], res->colSizes[level] * sizeof(int));
    res->ret[level][res->colSizes[level] - 1] = node->val;

    traverse(node->left, level + 1, res);
    traverse(node->right, level + 1, res);
}

int** levelOrder(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    Result res;
    res.ret = NULL;
    res.colSizes = NULL;
    res.returnSize = 0;

    traverse(root, 0, &res);

    *returnSize = res.returnSize;
    *returnColumnSizes = res.colSizes;
    return res.ret;
}