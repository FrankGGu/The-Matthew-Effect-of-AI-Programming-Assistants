class Solution {
    public Node construct(int[][] grid) {
        return helper(grid, 0, 0, grid.length);
    }

    private Node helper(int[][] grid, int x, int y, int size) {
        if (size == 1) {
            return new Node(grid[x][y] == 1, true);
        }

        Node topLeft = helper(grid, x, y, size / 2);
        Node topRight = helper(grid, x, y + size / 2, size / 2);
        Node bottomLeft = helper(grid, x + size / 2, y, size / 2);
        Node bottomRight = helper(grid, x + size / 2, y + size / 2, size / 2);

        if (topLeft.isLeaf && topRight.isLeaf && bottomLeft.isLeaf && bottomRight.isLeaf &&
           topLeft.val == topRight.val && topRight.val == bottomLeft.val && bottomLeft.val == bottomRight.val) {
            return new Node(topLeft.val, true);
        } else {
            return new Node(false, false, topLeft, topRight, bottomLeft, bottomRight);
        }
    }
}