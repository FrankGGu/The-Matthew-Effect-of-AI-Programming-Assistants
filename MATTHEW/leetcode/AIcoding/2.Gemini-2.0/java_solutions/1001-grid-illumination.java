class Solution {
    public int[] gridIllumination(int n, int[][] lamps, int[][] queries) {
        Map<Integer, Integer> row = new HashMap<>();
        Map<Integer, Integer> col = new HashMap<>();
        Map<Integer, Integer> diag1 = new HashMap<>();
        Map<Integer, Integer> diag2 = new HashMap<>();
        Set<Long> illuminated = new HashSet<>();

        for (int[] lamp : lamps) {
            int r = lamp[0];
            int c = lamp[1];
            long key = ((long) r << 32) | c;
            if (illuminated.contains(key)) continue;
            illuminated.add(key);

            row.put(r, row.getOrDefault(r, 0) + 1);
            col.put(c, col.getOrDefault(c, 0) + 1);
            diag1.put(r - c, diag1.getOrDefault(r - c, 0) + 1);
            diag2.put(r + c, diag2.getOrDefault(r + c, 0) + 1);
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int r = queries[i][0];
            int c = queries[i][1];

            if (row.containsKey(r) || col.containsKey(c) || diag1.containsKey(r - c) || diag2.containsKey(r + c)) {
                result[i] = 1;
            } else {
                result[i] = 0;
            }

            for (int dr = -1; dr <= 1; dr++) {
                for (int dc = -1; dc <= 1; dc++) {
                    int nr = r + dr;
                    int nc = c + dc;
                    if (nr >= 0 && nr < n && nc >= 0 && nc < n) {
                        long key = ((long) nr << 32) | nc;
                        if (illuminated.contains(key)) {
                            illuminated.remove(key);
                            row.put(nr, row.get(nr) - 1);
                            if (row.get(nr) == 0) row.remove(nr);
                            col.put(nc, col.get(nc) - 1);
                            if (col.get(nc) == 0) col.remove(nc);
                            diag1.put(nr - nc, diag1.get(nr - nc) - 1);
                            if (diag1.get(nr - nc) == 0) diag1.remove(nr - nc);
                            diag2.put(nr + nc, diag2.get(nr + nc) - 1);
                            if (diag2.get(nr + nc) == 0) diag2.remove(nr + nc);
                        }
                    }
                }
            }
        }

        return result;
    }
}