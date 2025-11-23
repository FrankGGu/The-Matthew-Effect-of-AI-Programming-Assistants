/**
 * Definition for a QuadTree node.
 * struct Node {
 *     int val;
 *     int isLeaf;
 *     struct Node* topLeft;
 *     struct Node* topRight;
 *     struct Node* bottomLeft;
 *     struct Node* bottomRight;
 * };
 */

struct Node* createNode(int isLeaf, int val) {
    struct Node* node = (struct Node*)malloc(sizeof(struct Node));
    node->isLeaf = isLeaf;
    node->val = val;
    node->topLeft = NULL;
    node->topRight = NULL;
    node->bottomLeft = NULL;
    node->bottomRight = NULL;
    return node;
}

struct Node* construct(int** grid, int gridSize, int* gridColSize) {
    return buildTree(grid, 0, 0, gridSize);
}

struct Node* buildTree(int** grid, int x, int y, int size) {
    if (size == 1) {
        return createNode(1, grid[x][y]);
    }

    int half = size / 2;
    struct Node* topLeft = buildTree(grid, x, y, half);
    struct Node* topRight = buildTree(grid, x, y + half, half);
    struct Node* bottomLeft = buildTree(grid, x + half, y, half);
    struct Node* bottomRight = buildTree(grid, x + half, y + half, half);

    if (topLeft->isLeaf && topRight->isLeaf && bottomLeft->isLeaf && bottomRight->isLeaf &&
        topLeft->val == topRight->val && topRight->val == bottomLeft->val && bottomLeft->val == bottomRight->val) {
        int val = topLeft->val;
        free(topLeft);
        free(topRight);
        free(bottomLeft);
        free(bottomRight);
        return createNode(1, val);
    }

    struct Node* node = createNode(0, 1);
    node->topLeft = topLeft;
    node->topRight = topRight;
    node->bottomLeft = bottomLeft;
    node->bottomRight = bottomRight;
    return node;
}