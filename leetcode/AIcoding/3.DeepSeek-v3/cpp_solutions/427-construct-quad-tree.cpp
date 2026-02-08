class Solution {
public:
    Node* construct(vector<vector<int>>& grid) {
        return helper(grid, 0, 0, grid.size());
    }

    Node* helper(vector<vector<int>>& grid, int x, int y, int len) {
        if (len == 1) {
            return new Node(grid[x][y], true);
        }

        Node* topLeft = helper(grid, x, y, len / 2);
        Node* topRight = helper(grid, x, y + len / 2, len / 2);
        Node* bottomLeft = helper(grid, x + len / 2, y, len / 2);
        Node* bottomRight = helper(grid, x + len / 2, y + len / 2, len / 2);

        if (topLeft->isLeaf && topRight->isLeaf && bottomLeft->isLeaf && bottomRight->isLeaf &&
            topLeft->val == topRight->val && topRight->val == bottomLeft->val && bottomLeft->val == bottomRight->val) {
            bool val = topLeft->val;
            delete topLeft;
            delete topRight;
            delete bottomLeft;
            delete bottomRight;
            return new Node(val, true);
        } else {
            return new Node(false, false, topLeft, topRight, bottomLeft, bottomRight);
        }
    }
};