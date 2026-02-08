class Solution {
    public int numberWays(List<List<Integer>> hats) {
        int n = hats.size();
        int MOD = 1000000007;
        int maxHat = 0;
        for (List<Integer> person : hats) {
            for (int hat : person) {
                maxHat = Math.max(maxHat, hat);
            }
        }
        List<Integer>[] hatToPeople = new List[maxHat + 1];
        for (int i = 0; i <= maxHat; i++) {
            hatToPeople[i] = new ArrayList<>();
        }
        for (int person = 0; person < n; person++) {
            for (int hat : hats.get(person)) {
                hatToPeople[hat].add(person);
            }
        }
        int[] dp = new int[1 << n];
        dp[0] = 1;
        for (int hat = 1; hat <= maxHat; hat++) {
            for (int mask = (1 << n) - 1; mask >= 0; mask--) {
                for (int person : hatToPeople[hat]) {
                    if ((mask & (1 << person)) == 0) {
                        int newMask = mask | (1 << person);
                        dp[newMask] = (dp[newMask] + dp[mask]) % MOD;
                    }
                }
            }
        }
        return dp[(1 << n) - 1];
    }
}