class Solution {
    public int minDays(int n) {
        Map<Integer, Integer> memo = new HashMap<>();
        return dfs(n, memo);
    }

    private int dfs(int n, Map<Integer, Integer> memo) {
        if (n <= 1) {
            return n;
        }
        if (memo.containsKey(n)) {
            return memo.get(n);
        }
        int res = Math.min(n % 2 + 1 + dfs(n / 2, memo), n % 3 + 1 + dfs(n / 3, memo));
        memo.put(n, res);
        return res;
    }
}