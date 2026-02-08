/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

typedef struct {
    int val;
    int color;
} NodeInfo;

int cmp(const void* a, const void* b) {
    return ((NodeInfo*)a)->val - ((NodeInfo*)b)->val;
}

void inorder(struct TreeNode* root, NodeInfo* nodes, int* idx) {
    if (root == NULL) return;
    inorder(root->left, nodes, idx);
    nodes[*idx].val = root->val;
    nodes[*idx].color = 0;
    (*idx)++;
    inorder(root->right, nodes, idx);
}

int getNumber(struct TreeNode* root, int** ops, int opsSize, int* opsColSize) {
    int n = 0;
    void countNodes(struct TreeNode* node) {
        if (node == NULL) return;
        countNodes(node->left);
        n++;
        countNodes(node->right);
    }
    countNodes(root);

    NodeInfo* nodes = (NodeInfo*)malloc(n * sizeof(NodeInfo));
    int idx = 0;
    inorder(root, nodes, &idx);

    for (int i = opsSize - 1; i >= 0; i--) {
        int type = ops[i][0];
        int x = ops[i][1];
        int y = ops[i][2];

        int left = 0, right = n - 1;
        int start = -1, end = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (nodes[mid].val >= x) {
                start = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        left = 0; right = n - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (nodes[mid].val <= y) {
                end = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (start == -1 || end == -1 || start > end) continue;

        for (int j = start; j <= end; j++) {
            if (nodes[j].color == 0) {
                nodes[j].color = type + 1;
            }
        }
    }

    int redCount = 0;
    for (int i = 0; i < n; i++) {
        if (nodes[i].color == 2) {
            redCount++;
        }
    }

    free(nodes);
    return redCount;
}