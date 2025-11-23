class Solution {
    public int findRotateSteps(String ring, String key) {
        int n = ring.length();
        int m = key.length();
        Map<Character, List<Integer>> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            char c = ring.charAt(i);
            if (!map.containsKey(c)) {
                map.put(c, new ArrayList<>());
            }
            map.get(c).add(i);
        }
        int[][] dp = new int[m][n];
        for (int[] row : dp) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        for (int pos : map.get(key.charAt(0))) {
            dp[0][pos] = Math.min(pos, n - pos) + 1;
        }
        for (int i = 1; i < m; i++) {
            for (int pos : map.get(key.charAt(i))) {
                for (int prevPos : map.get(key.charAt(i - 1))) {
                    int diff = Math.abs(pos - prevPos);
                    int step = Math.min(diff, n - diff);
                    dp[i][pos] = Math.min(dp[i][pos], dp[i - 1][prevPos] + step + 1);
                }
            }
        }
        int minSteps = Integer.MAX_VALUE;
        for (int pos : map.get(key.charAt(m - 1))) {
            minSteps = Math.min(minSteps, dp[m - 1][pos]);
        }
        return minSteps;
    }
}