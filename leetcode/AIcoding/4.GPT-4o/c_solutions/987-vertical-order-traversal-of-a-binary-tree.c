#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node {
    struct TreeNode* treeNode;
    int x;
    int y;
};

int cmp(const void* a, const void* b) {
    struct Node* nodeA = (struct Node*)a;
    struct Node* nodeB = (struct Node*)b;
    if (nodeA->x != nodeB->x) return nodeA->x - nodeB->x;
    return nodeA->y - nodeB->y;
}

void dfs(struct TreeNode* root, int x, int y, struct Node* nodes, int* index) {
    if (!root) return;
    nodes[(*index)++] = (struct Node){root, x, y};
    dfs(root->left, x - 1, y + 1, nodes, index);
    dfs(root->right, x + 1, y + 1, nodes, index);
}

int** verticalTraversal(struct TreeNode* root, int** returnColumnSizes, int* returnSize) {
    struct Node nodes[1000];
    int index = 0;
    dfs(root, 0, 0, nodes, &index);
    qsort(nodes, index, sizeof(struct Node), cmp);

    int currentX = nodes[0].x;
    int count = 0;
    int** result = malloc(1000 * sizeof(int*));
    *returnColumnSizes = malloc(1000 * sizeof(int));

    for (int i = 0; i < index; i++) {
        if (nodes[i].x != currentX) {
            result[count] = malloc((i - (i - count)) * sizeof(int));
            (*returnColumnSizes)[count] = i - (i - count);
            count++;
            currentX = nodes[i].x;
        }
        result[count - 1][i - (i - count)] = nodes[i].treeNode->val;
    }

    *returnSize = count;
    return result;
}