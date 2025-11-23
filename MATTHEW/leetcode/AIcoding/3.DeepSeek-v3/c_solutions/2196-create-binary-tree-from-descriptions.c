/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */
struct TreeNode* createBinaryTree(int** descriptions, int descriptionsSize, int* descriptionsColSize) {
    struct TreeNode* nodes[100001] = {NULL};
    int hasParent[100001] = {0};

    for (int i = 0; i < descriptionsSize; i++) {
        int parent = descriptions[i][0];
        int child = descriptions[i][1];
        int isLeft = descriptions[i][2];

        if (nodes[parent] == NULL) {
            nodes[parent] = malloc(sizeof(struct TreeNode));
            nodes[parent]->val = parent;
            nodes[parent]->left = NULL;
            nodes[parent]->right = NULL;
        }

        if (nodes[child] == NULL) {
            nodes[child] = malloc(sizeof(struct TreeNode));
            nodes[child]->val = child;
            nodes[child]->left = NULL;
            nodes[child]->right = NULL;
        }

        if (isLeft) {
            nodes[parent]->left = nodes[child];
        } else {
            nodes[parent]->right = nodes[child];
        }

        hasParent[child] = 1;
    }

    for (int i = 1; i <= 100000; i++) {
        if (nodes[i] != NULL && !hasParent[i]) {
            return nodes[i];
        }
    }

    return NULL;
}