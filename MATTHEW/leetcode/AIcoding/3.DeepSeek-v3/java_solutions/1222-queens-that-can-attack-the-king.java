class Solution {
    public List<List<Integer>> queensAttacktheKing(int[][] queens, int[] king) {
        List<List<Integer>> result = new ArrayList<>();
        boolean[][] queenPositions = new boolean[8][8];
        for (int[] queen : queens) {
            queenPositions[queen[0]][queen[1]] = true;
        }
        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}};
        for (int[] dir : directions) {
            int x = king[0] + dir[0];
            int y = king[1] + dir[1];
            while (x >= 0 && x < 8 && y >= 0 && y < 8) {
                if (queenPositions[x][y]) {
                    result.add(Arrays.asList(x, y));
                    break;
                }
                x += dir[0];
                y += dir[1];
            }
        }
        return result;
    }
}