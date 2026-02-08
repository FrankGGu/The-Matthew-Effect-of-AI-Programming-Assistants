/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */
/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
char *** printTree(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    if (root == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int height = 0;
    struct TreeNode* queue[1000];
    int front = 0, rear = 0;
    queue[rear++] = root;

    while (front < rear) {
        int levelSize = rear - front;
        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }
        height++;
    }

    int m = height;
    int n = (1 << height) - 1;

    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    char ***res = (char***)malloc(m * sizeof(char**));
    for (int i = 0; i < m; i++) {
        res[i] = (char**)malloc(n * sizeof(char*));
        for (int j = 0; j < n; j++) {
            res[i][j] = (char*)malloc(12 * sizeof(char));
            strcpy(res[i][j], "");
        }
    }

    struct QueueNode {
        struct TreeNode* node;
        int row;
        int col;
    };

    struct QueueNode q[1000];
    front = 0, rear = 0;
    q[rear].node = root;
    q[rear].row = 0;
    q[rear].col = (n - 1) / 2;
    rear++;

    while (front < rear) {
        struct QueueNode curr = q[front++];
        struct TreeNode* node = curr.node;
        int r = curr.row;
        int c = curr.col;

        sprintf(res[r][c], "%d", node->val);

        if (node->left) {
            q[rear].node = node->left;
            q[rear].row = r + 1;
            q[rear].col = c - (1 << (height - r - 2));
            rear++;
        }

        if (node->right) {
            q[rear].node = node->right;
            q[rear].row = r + 1;
            q[rear].col = c + (1 << (height - r - 2));
            rear++;
        }
    }

    return res;
}