class Solution {
    public int[][] findFarmland(int[][] land) {
        List<int[]> result = new ArrayList<>();
        int m = land.length;
        int n = land[0].length;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (land[i][j] == 1) {
                    int[] coordinates = new int[4];
                    coordinates[0] = i;
                    coordinates[1] = j;
                    int r = i;
                    int c = j;

                    while (r < m && land[r][j] == 1) {
                        r++;
                    }
                    while (c < n && land[i][c] == 1) {
                        c++;
                    }
                    coordinates[2] = r - 1;
                    coordinates[3] = c - 1;

                    for (int x = i; x <= r - 1; x++) {
                        for (int y = j; y <= c - 1; y++) {
                            land[x][y] = 0;
                        }
                    }

                    result.add(coordinates);
                }
            }
        }

        return result.toArray(new int[result.size()][]);
    }
}