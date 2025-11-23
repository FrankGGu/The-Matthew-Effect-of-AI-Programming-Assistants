class Solution {
    public int minimumArea(char[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int minTotalArea = Integer.MAX_VALUE;

        // Helper function to calculate the area of the minimum bounding box
        // for '1's within a specified subgrid (r1, c1) to (r2, c2).
        // Returns Integer.MAX_VALUE if no '1's are found in the subgrid.
        java.util.function.Function<int[], Integer> calculateArea = (coords) -> {
            int r1 = coords[0], c1 = coords[1], r2 = coords[2], c2 = coords[3];
            int minR = m, maxR = -1;
            int minC = n, maxC = -1;
            boolean foundOne = false;

            for (int i = r1; i <= r2; i++) {
                for (int j = c1; j <= c2; j++) {
                    if (grid[i][j] == '1') {
                        foundOne = true;
                        minR = Math.min(minR, i);
                        maxR = Math.max(maxR, i);
                        minC = Math.min(minC, j);
                        maxC = Math.max(maxC, j);
                    }
                }
            }

            if (!foundOne) {
                return Integer.MAX_VALUE;
            }
            return (maxR - minR + 1) * (maxC - minC + 1);
        };

        // Case 1: Three horizontal strips
        // R1: (0,0) to (r1_end, n-1)
        // R2: (r1_end+1, 0) to (r2_end, n-1)
        // R3: (r2_end+1, 0) to (m-1, n-1)
        for (int r1_end = 0; r1_end < m - 2; r1_end++) {
            for (int r2_end = r1_end + 1; r2_end < m - 1; r2_end++) {
                int area1 = calculateArea.apply(new int[]{0, 0, r1_end, n - 1});
                int area2 = calculateArea.apply(new int[]{r1_end + 1, 0, r2_end, n - 1});
                int area3 = calculateArea.apply(new int[]{r2_end + 1, 0, m - 1, n - 1});
                if (area1 != Integer.MAX_VALUE && area2 != Integer.MAX_VALUE && area3 != Integer.MAX_VALUE) {
                    minTotalArea = Math.min(minTotalArea, area1 + area2 + area3);
                }
            }
        }

        // Case 2: Three vertical strips
        // R1: (0,0) to (m-1, c1_end)
        // R2: (0, c1_end+1) to (m-1, c2_end)
        // R3: (0, c2_end+1) to (m-1, n-1)
        for (int c1_end = 0; c1_end < n - 2; c1_end++) {
            for (int c2_end = c1_end + 1; c2_end < n - 1; c2_end++) {
                int area1 = calculateArea.apply(new int[]{0, 0, m - 1, c1_end});
                int area2 = calculateArea.apply(new int[]{0, c1_end + 1, m - 1, c2_end});
                int area3 = calculateArea.apply(new int[]{0, c2_end + 1, m - 1, n - 1});
                if (area1 != Integer.MAX_VALUE && area2 != Integer.MAX_VALUE && area3 != Integer.MAX_VALUE) {
                    minTotalArea = Math.min(minTotalArea, area1 + area2 + area3);
                }
            }
        }

        // Case 3a: One horizontal strip at the top, remaining part split vertically
        // R1: (0,0) to (r_split, n-1)
        // R2: (r_split+1, 0) to (m-1, c_split)
        // R3: (r_split+1, c_split+1) to (m-1, n-1)
        for (int r_split = 0; r_split < m - 1; r_split++) {
            int area1 = calculateArea.apply(new int[]{0, 0, r_split, n - 1});
            if (area1 == Integer.MAX_VALUE) continue;

            for (int c_split = 0; c_split < n - 1; c_split++) {
                int area2 = calculateArea.apply(new int[]{r_split + 1, 0, m - 1, c_split});
                int area3 = calculateArea.apply(new int[]{r_split + 1, c_split + 1, m - 1, n - 1});
                if (area2 != Integer.MAX_VALUE && area3 != Integer.MAX_VALUE) {
                    minTotalArea = Math.min(minTotalArea, area1 + area2 + area3);
                }
            }
        }

        // Case 3b: One horizontal strip at the bottom, remaining part split vertically
        // R1: (r_split+1, 0) to (m-1, n-1)
        // R2: (0,0) to (r_split, c_split)
        // R3: (0, c_split+1) to (r_split, n-1)
        for (int r_split = 0; r_split < m - 1; r_split++) {
            int area1 = calculateArea.apply(new int[]{r_split + 1, 0, m - 1, n - 1});
            if (area1 == Integer.MAX_VALUE) continue;

            for (int c_split = 0; c_split < n - 1; c_split++) {
                int area2 = calculateArea.apply(new int[]{0, 0, r_split, c_split});
                int area3 = calculateArea.apply(new int[]{0, c_split + 1, r_split, n - 1});
                if (area2 != Integer.MAX_VALUE && area3 != Integer.MAX_VALUE) {
                    minTotalArea = Math.min(minTotalArea, area1 + area2 + area3);
                }
            }
        }

        // Case 4a: One vertical strip at the left, remaining part split horizontally
        // R1: (0,0) to (m-1, c_split)
        // R2: (0, c_split+1) to (r_split, n-1)
        // R3: (r_split+1, c_split+1) to (m-1, n-1)
        for (int c_split = 0; c_split < n - 1; c_split++) {
            int area1 = calculateArea.apply(new int[]{0, 0, m - 1, c_split});
            if (area1 == Integer.MAX_VALUE) continue;

            for (int r_split = 0; r_split < m - 1; r_split++) {
                int area2 = calculateArea.apply(new int[]{0, c_split + 1, r_split, n - 1});
                int area3 = calculateArea.apply(new int[]{r_split + 1, c_split + 1, m - 1, n - 1});
                if (area2 != Integer.MAX_VALUE && area3 != Integer.MAX_VALUE) {
                    minTotalArea = Math.min(minTotalArea, area1 + area2 + area3);
                }
            }
        }

        // Case 4b: One vertical strip at the right, remaining part split horizontally
        // R1: (0, c_split+1) to (m-1, n-1)
        // R2: (0,0) to (r_split, c_split)
        // R3: (r_split+1, 0) to (m-1, c_split)
        for (int c_split = 0; c_split < n - 1; c_split++) {
            int area1 = calculateArea.apply(new int[]{0, c_split + 1, m - 1, n - 1});
            if (area1 == Integer.MAX_VALUE) continue;

            for (int r_split = 0; r_split < m - 1; r_split++) {
                int area2 = calculateArea.apply(new int[]{0, 0, r_split, c_split});
                int area3 = calculateArea.apply(new int[]{r_split + 1, 0, m - 1, c_split});
                if (area2 != Integer.MAX_VALUE && area3 != Integer.MAX_VALUE) {
                    minTotalArea = Math.min(minTotalArea, area1 + area2 + area3);
                }
            }
        }

        return minTotalArea;
    }
}