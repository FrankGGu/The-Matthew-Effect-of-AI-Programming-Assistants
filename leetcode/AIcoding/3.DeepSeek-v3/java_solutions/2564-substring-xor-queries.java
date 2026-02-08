class Solution {
    public int[][] substringXorQueries(String s, int[][] queries) {
        Map<Integer, int[]> map = new HashMap<>();
        int n = s.length();
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '0') {
                if (!map.containsKey(0)) {
                    map.put(0, new int[]{i, i});
                }
                continue;
            }
            int num = 0;
            for (int j = i; j < Math.min(i + 30, n); j++) {
                num = (num << 1) | (s.charAt(j) - '0');
                if (!map.containsKey(num)) {
                    map.put(num, new int[]{i, j});
                }
            }
        }
        int[][] res = new int[queries.length][2];
        for (int i = 0; i < queries.length; i++) {
            int val = queries[i][0] ^ queries[i][1];
            res[i] = map.getOrDefault(val, new int[]{-1, -1});
        }
        return res;
    }
}