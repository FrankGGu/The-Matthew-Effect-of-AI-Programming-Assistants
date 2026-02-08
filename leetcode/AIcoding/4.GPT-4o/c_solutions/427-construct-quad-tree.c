typedef struct Node {
    bool val;
    bool isLeaf;
    struct Node *topLeft;
    struct Node *topRight;
    struct Node *bottomLeft;
    struct Node *bottomRight;
} Node;

Node* construct(int** grid, int r0, int c0, int r1, int c1) {
    if (r0 >= r1 || c0 >= c1) return NULL;

    bool isLeaf = true;
    int firstValue = grid[r0][c0];
    for (int i = r0; i < r1; i++) {
        for (int j = c0; j < c1; j++) {
            if (grid[i][j] != firstValue) {
                isLeaf = false;
                break;
            }
        }
        if (!isLeaf) break;
    }

    Node* node = (Node*)malloc(sizeof(Node));
    node->val = firstValue;
    node->isLeaf = isLeaf;

    if (!isLeaf) {
        int midRow = (r0 + r1) / 2;
        int midCol = (c0 + c1) / 2;
        node->topLeft = construct(grid, r0, c0, midRow, midCol);
        node->topRight = construct(grid, r0, midCol, midRow, c1);
        node->bottomLeft = construct(grid, midRow, c0, r1, midCol);
        node->bottomRight = construct(grid, midRow, midCol, r1, c1);
    } else {
        node->topLeft = node->topRight = node->bottomLeft = node->bottomRight = NULL;
    }

    return node;
}

Node* constructQuadTree(int** grid, int gridSize, int* gridColSize) {
    return construct(grid, 0, 0, gridSize, gridColSize[0]);
}