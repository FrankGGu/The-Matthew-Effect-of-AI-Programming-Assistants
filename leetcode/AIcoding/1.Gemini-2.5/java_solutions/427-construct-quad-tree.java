class Solution {
    public Node construct(int[][] grid) {
        if (grid == null || grid.length == 0 || grid[0].length == 0) {
            return null;
        }
        return buildQuadTree(grid, 0, 0, grid.length);
    }

    private Node buildQuadTree(int[][] grid, int rowStart, int colStart, int size) {
        if (isAllSame(grid, rowStart, colStart, size)) {
            boolean val = grid[rowStart][colStart] == 1;
            return new Node(val, true);
        } else {
            Node node = new Node(false, false);
            int halfSize = size / 2;
            node.topLeft = buildQuadTree(grid, rowStart, colStart, halfSize);
            node.topRight = buildQuadTree(grid, rowStart, colStart + halfSize, halfSize);
            node.bottomLeft = buildQuadTree(grid, rowStart + halfSize, colStart, halfSize);
            node.bottomRight = buildQuadTree(grid, rowStart + halfSize, colStart + halfSize, halfSize);
            return node;
        }
    }

    private boolean isAllSame(int[][] grid, int rowStart, int colStart, int size) {
        int firstVal = grid[rowStart][colStart];
        for (int i = rowStart; i < rowStart + size; i++) {
            for (int j = colStart; j < colStart + size; j++) {
                if (grid[i][j] != firstVal) {
                    return false;
                }
            }
        }
        return true;
    }
}