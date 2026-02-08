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

    Node* constructHelper(vector<vector<int>>& grid, int rowStart, int colStart, int len) {
        if (len == 0) {
            return nullptr;
        }

        bool allSame = true;
        int firstVal = grid[rowStart][colStart];
        for (int i = rowStart; i < rowStart + len; ++i) {
            for (int j = colStart; j < colStart + len; ++j) {
                if (grid[i][j] != firstVal) {
                    allSame = false;
                    break;
                }
            }
            if (!allSame) {
                break;
            }
        }

        if (allSame) {
            return new Node(firstVal == 1, true);
        }

        int newLen = len / 2;
        Node* topLeft = constructHelper(grid, rowStart, colStart, newLen);
        Node* topRight = constructHelper(grid, rowStart, colStart + newLen, newLen);
        Node* bottomLeft = constructHelper(grid, rowStart + newLen, colStart, newLen);
        Node* bottomRight = constructHelper(grid, rowStart + newLen, colStart + newLen, newLen);

        return new Node(false, false, topLeft, topRight, bottomLeft, bottomRight);
    }
};