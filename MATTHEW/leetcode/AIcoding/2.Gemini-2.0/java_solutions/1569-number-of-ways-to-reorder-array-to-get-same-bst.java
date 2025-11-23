class Solution {

    private static final int MOD = 1_000_000_007;

    public int numOfWays(int[] nums) {
        int n = nums.length;
        long[][] comb = new long[n + 1][n + 1];
        for (int i = 0; i <= n; i++) {
            comb[i][0] = comb[i][i] = 1;
            for (int j = 1; j < i; j++) {
                comb[i][j] = (comb[i - 1][j - 1] + comb[i - 1][j]) % MOD;
            }
        }
        return (int) (dfs(nums, comb) - 1);
    }

    private long dfs(int[] nums, long[][] comb) {
        int n = nums.length;
        if (n <= 1) {
            return 1;
        }
        int root = nums[0];
        List<Integer> left = new ArrayList<>();
        List<Integer> right = new ArrayList<>();
        for (int i = 1; i < n; i++) {
            if (nums[i] < root) {
                left.add(nums[i]);
            } else {
                right.add(nums[i]);
            }
        }
        int leftSize = left.size();
        int rightSize = right.size();
        long leftWays = dfs(left.stream().mapToInt(Integer::intValue).toArray(), comb);
        long rightWays = dfs(right.stream().mapToInt(Integer::intValue).toArray(), comb);
        return (((comb[n - 1][leftSize] * leftWays) % MOD) * rightWays) % MOD;
    }
}