class Solution {
    public List<Integer> goodSubsetofBinaryMatrix(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < m; i++) {
            int mask = 0;
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    mask |= (1 << j);
                }
            }
            if (mask == 0) {
                return Arrays.asList(i);
            }
            map.put(mask, i);
        }
        for (int x : map.keySet()) {
            for (int y : map.keySet()) {
                if ((x & y) == 0) {
                    int i = map.get(x);
                    int j = map.get(y);
                    if (i < j) {
                        return Arrays.asList(i, j);
                    } else {
                        return Arrays.asList(j, i);
                    }
                }
            }
        }
        return new ArrayList<>();
    }
}