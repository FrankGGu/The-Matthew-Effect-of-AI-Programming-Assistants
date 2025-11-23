class Solution {
    public int[] gridIllumination(int n, int[][] lamps, int[][] queries) {
        Map<Integer, Integer> row = new HashMap<>();
        Map<Integer, Integer> col = new HashMap<>();
        Map<Integer, Integer> diag1 = new HashMap<>();
        Map<Integer, Integer> diag2 = new HashMap<>();
        Set<Long> lampSet = new HashSet<>();

        for (int[] lamp : lamps) {
            int r = lamp[0], c = lamp[1];
            long key = (long) r * n + c;
            if (lampSet.contains(key)) continue;
            lampSet.add(key);
            row.put(r, row.getOrDefault(r, 0) + 1);
            col.put(c, col.getOrDefault(c, 0) + 1);
            diag1.put(r - c, diag1.getOrDefault(r - c, 0) + 1);
            diag2.put(r + c, diag2.getOrDefault(r + c, 0) + 1);
        }

        int[] result = new int[queries.length];
        int[][] dirs = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 0}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};

        for (int i = 0; i < queries.length; i++) {
            int r = queries[i][0], c = queries[i][1];
            if (row.getOrDefault(r, 0) > 0 || col.getOrDefault(c, 0) > 0 || 
                diag1.getOrDefault(r - c, 0) > 0 || diag2.getOrDefault(r + c, 0) > 0) {
                result[i] = 1;
            } else {
                result[i] = 0;
            }

            for (int[] dir : dirs) {
                int nr = r + dir[0], nc = c + dir[1];
                if (nr >= 0 && nr < n && nc >= 0 && nc < n) {
                    long key = (long) nr * n + nc;
                    if (lampSet.contains(key)) {
                        lampSet.remove(key);
                        row.put(nr, row.get(nr) - 1);
                        col.put(nc, col.get(nc) - 1);
                        diag1.put(nr - nc, diag1.get(nr - nc) - 1);
                        diag2.put(nr + nc, diag2.get(nr + nc) - 1);
                    }
                }
            }
        }

        return result;
    }
}