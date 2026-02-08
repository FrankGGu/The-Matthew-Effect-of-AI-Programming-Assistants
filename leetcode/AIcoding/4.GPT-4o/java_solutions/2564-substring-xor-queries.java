class Solution {
    public int[] substringXorQueries(String s, int[][] queries) {
        int n = s.length();
        Map<Long, int[]> map = new HashMap<>();
        int[] result = new int[queries.length];

        for (int i = 0; i < n; i++) {
            long xor = 0;
            for (int j = i; j < Math.min(i + 32, n); j++) {
                xor = (xor << 1) | (s.charAt(j) - '0');
                if (!map.containsKey(xor)) {
                    map.put(xor, new int[] {i, j});
                }
            }
        }

        for (int i = 0; i < queries.length; i++) {
            long query = queries[i][0];
            if (map.containsKey(query)) {
                result[i] = map.get(query);
            } else {
                result[i] = new int[] {-1, -1};
            }
        }

        return result;
    }
}