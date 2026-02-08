class Solution {
    public int equalPairs(int[][] grid) {
        int n = grid.length;
        Map<String, Integer> rowMap = new HashMap<>();
        for (int[] row : grid) {
            StringBuilder sb = new StringBuilder();
            for (int num : row) {
                sb.append(num).append(",");
            }
            String key = sb.toString();
            rowMap.put(key, rowMap.getOrDefault(key, 0) + 1);
        }

        int count = 0;
        for (int j = 0; j < n; j++) {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < n; i++) {
                sb.append(grid[i][j]).append(",");
            }
            String key = sb.toString();
            count += rowMap.getOrDefault(key, 0);
        }
        return count;
    }
}