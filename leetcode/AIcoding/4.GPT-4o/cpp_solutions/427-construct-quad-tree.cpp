class Node {
public:
    bool val;
    bool isLeaf;
    Node* topLeft;
    Node* topRight;
    Node* bottomLeft;
    Node* bottomRight;

    Node() : val(false), isLeaf(false), topLeft(nullptr), topRight(nullptr), bottomLeft(nullptr), bottomRight(nullptr) {}

    Node(bool _val, bool _isLeaf) : val(_val), isLeaf(_isLeaf), topLeft(nullptr), topRight(nullptr), bottomLeft(nullptr), bottomRight(nullptr) {}
};

class Solution {
public:
    Node* construct(vector<vector<int>>& grid) {
        return construct(grid, 0, 0, grid.size());
    }

    Node* construct(vector<vector<int>>& grid, int x, int y, int size) {
        if (size == 1) {
            return new Node(grid[x][y] == 1, true);
        }

        Node* topLeft = construct(grid, x, y, size / 2);
        Node* topRight = construct(grid, x, y + size / 2, size / 2);
        Node* bottomLeft = construct(grid, x + size / 2, y, size / 2);
        Node* bottomRight = construct(grid, x + size / 2, y + size / 2, size / 2);

        if (topLeft->isLeaf && topRight->isLeaf && bottomLeft->isLeaf && bottomRight->isLeaf &&
            topLeft->val == topRight->val && topLeft->val == bottomLeft->val && topLeft->val == bottomRight->val) {
            return new Node(topLeft->val, true);
        }

        Node* root = new Node(false, false);
        root->topLeft = topLeft;
        root->topRight = topRight;
        root->bottomLeft = bottomLeft;
        root->bottomRight = bottomRight;
        return root;
    }
};