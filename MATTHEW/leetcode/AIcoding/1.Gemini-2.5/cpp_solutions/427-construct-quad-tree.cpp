class Node {
public:
    bool val;
    bool isLeaf;
    Node* topLeft;
    Node* topRight;
    Node* bottomLeft;
    Node* bottomRight;

    Node() {
        val = false;
        isLeaf = false;
        topLeft = nullptr;
        topRight = nullptr;
        bottomLeft = nullptr;
        bottomRight = nullptr;
    }

    Node(bool _val, bool _isLeaf) {
        val = _val;
        isLeaf = _isLeaf;
        topLeft = nullptr;
        topRight = nullptr;
        bottomLeft = nullptr;
        bottomRight = nullptr;
    }

    Node(bool _val, bool _isLeaf, Node* _topLeft, Node* _topRight, Node* _bottomLeft, Node* _bottomRight) {
        val = _val;
        isLeaf = _isLeaf;
        topLeft = _topLeft;
        topRight = _topRight;
        bottomLeft = _bottomLeft;
        bottomRight = _bottomRight;
    }
};

class Solution {
public:
    Node* construct(vector<vector<int>>& grid) {
        return constructHelper(grid, 0, 0, grid.size());
    }

private:
    Node* constructHelper(vector<vector<int>>& grid, int row, int col, int len) {
        if (len == 1) {
            return new Node(grid[row][col] == 1, true);
        }

        Node* topLeft = constructHelper(grid, row, col, len / 2);
        Node* topRight = constructHelper(grid, row, col + len / 2, len / 2);
        Node* bottomLeft = constructHelper(grid, row + len / 2, col, len / 2);
        Node* bottomRight = constructHelper(grid, row + len / 2, col + len / 2, len / 2);

        if (topLeft->isLeaf && topRight->isLeaf && bottomLeft->isLeaf && bottomRight->isLeaf &&
            topLeft->val == topRight->val && topRight->val == bottomLeft->val && bottomLeft->val == bottomRight->val) {
            return new Node(topLeft->val, true);
        }

        return new Node(false, false, topLeft, topRight, bottomLeft, bottomRight);
    }
};