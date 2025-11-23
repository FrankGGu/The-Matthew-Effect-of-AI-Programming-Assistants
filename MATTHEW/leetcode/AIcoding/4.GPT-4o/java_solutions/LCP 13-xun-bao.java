class Solution {
    public int[] findTreasure(String[][] grid) {
        int[] direction = {0, 1, 0, -1, 0}; // Right, Down, Left, Up
        int x = 0, y = 0;

        for (char ch : grid[0][0].toCharArray()) {
            if (ch == 'R') {
                x += direction[0];
                y += direction[1];
            } else if (ch == 'D') {
                x += direction[1];
                y += direction[2];
            } else if (ch == 'L') {
                x += direction[2];
                y += direction[3];
            } else if (ch == 'U') {
                x += direction[3];
                y += direction[0];
            }
        }

        return new int[] {x, y};
    }
}