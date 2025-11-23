class Solution {
    public Node construct(int[][] grid) {
        int n = grid.length;
        return buildTree(grid, 0, 0, n);
    }

    private Node buildTree(int[][] grid, int rowStart, int colStart, int size) {
        if (size == 1) {
            return new Node(grid[rowStart][colStart] == 1, true);
        }

        boolean allSame = true;
        int firstValue = grid[rowStart][colStart];
        for (int i = rowStart; i < rowStart + size; i++) {
            for (int j = colStart; j < colStart + size; j++) {
                if (grid[i][j] != firstValue) {
                    allSame = false;
                    break;
                }
            }
            if (!allSame) {
                break;
            }
        }

        if (allSame) {
            return new Node(firstValue == 1, true);
        }

        int newSize = size / 2;
        Node topLeft = buildTree(grid, rowStart, colStart, newSize);
        Node topRight = buildTree(grid, rowStart, colStart + newSize, newSize);
        Node bottomLeft = buildTree(grid, rowStart + newSize, colStart, newSize);
        Node bottomRight = buildTree(grid, rowStart + newSize, colStart + newSize, newSize);

        return new Node(false, false, topLeft, topRight, bottomLeft, bottomRight);
    }
}