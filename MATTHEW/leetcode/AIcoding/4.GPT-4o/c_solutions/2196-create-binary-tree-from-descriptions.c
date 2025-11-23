struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* createBinaryTree(int** descriptions, int descriptionsSize, int* descriptionsColSize) {
    struct TreeNode* nodes[100001] = {NULL};
    int hasParent[100001] = {0};

    for (int i = 0; i < descriptionsSize; i++) {
        int parentVal = descriptions[i][0];
        int childVal = descriptions[i][1];
        int isLeft = descriptions[i][2];

        if (nodes[parentVal] == NULL) {
            nodes[parentVal] = (struct TreeNode*)malloc(sizeof(struct TreeNode));
            nodes[parentVal]->val = parentVal;
            nodes[parentVal]->left = NULL;
            nodes[parentVal]->right = NULL;
        }

        if (nodes[childVal] == NULL) {
            nodes[childVal] = (struct TreeNode*)malloc(sizeof(struct TreeNode));
            nodes[childVal]->val = childVal;
            nodes[childVal]->left = NULL;
            nodes[childVal]->right = NULL;
        }

        if (isLeft) {
            nodes[parentVal]->left = nodes[childVal];
        } else {
            nodes[parentVal]->right = nodes[childVal];
        }

        hasParent[childVal] = 1;
    }

    for (int i = 0; i < 100001; i++) {
        if (nodes[i] != NULL && hasParent[i] == 0) {
            return nodes[i];
        }
    }

    return NULL;
}