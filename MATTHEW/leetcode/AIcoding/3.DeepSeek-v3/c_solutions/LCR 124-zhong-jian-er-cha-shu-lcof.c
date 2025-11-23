/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
typedef struct {
    int* preorder;
    int* inorder;
    int preIndex;
    int inSize;
    int* postorder;
    int postIndex;
} TreeBuilder;

int findIndex(int* arr, int start, int end, int value) {
    for (int i = start; i <= end; i++) {
        if (arr[i] == value) {
            return i;
        }
    }
    return -1;
}

void buildPostorder(TreeBuilder* builder, int inStart, int inEnd) {
    if (inStart > inEnd) {
        return;
    }

    int rootVal = builder->preorder[builder->preIndex++];
    int rootIndex = findIndex(builder->inorder, inStart, inEnd, rootVal);

    buildPostorder(builder, inStart, rootIndex - 1);
    buildPostorder(builder, rootIndex + 1, inEnd);

    builder->postorder[builder->postIndex++] = rootVal;
}

int* buildTree(int* preorder, int preorderSize, int* inorder, int inorderSize, int* returnSize) {
    *returnSize = preorderSize;
    if (preorderSize == 0) {
        return NULL;
    }

    int* postorder = (int*)malloc(preorderSize * sizeof(int));
    TreeBuilder builder;
    builder.preorder = preorder;
    builder.inorder = inorder;
    builder.preIndex = 0;
    builder.inSize = inorderSize;
    builder.postorder = postorder;
    builder.postIndex = 0;

    buildPostorder(&builder, 0, inorderSize - 1);

    return postorder;
}