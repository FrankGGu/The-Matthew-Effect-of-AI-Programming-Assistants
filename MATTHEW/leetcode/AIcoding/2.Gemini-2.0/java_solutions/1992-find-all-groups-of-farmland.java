class Solution {
    public int[][] findFarmland(int[][] land) {
        int m = land.length;
        int n = land[0].length;
        List<int[]> result = new ArrayList<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (land[i][j] == 1) {
                    int bottom = i;
                    int right = j;

                    while (bottom + 1 < m && land[bottom + 1][j] == 1) {
                        bottom++;
                    }

                    while (right + 1 < n && land[i][right + 1] == 1) {
                        right++;
                    }

                    result.add(new int[]{i, j, bottom, right});

                    for (int row = i; row <= bottom; row++) {
                        for (int col = j; col <= right; col++) {
                            land[row][col] = 0;
                        }
                    }
                }
            }
        }

        return result.toArray(new int[result.size()][]);
    }
}