class Solution {
    public int minCostII(int[][] costs, int target) {
        int n = costs.length;
        int k = costs[0].length;

        Integer[][][] dp = new Integer[n + 1][target + 1][k];

        int ans = solve(costs, n, k, target, 0, 0, dp);
        return ans == (int) 1e9 ? -1 : ans;
    }

    private int solve(int[][] costs, int n, int k, int target, int index, int count, Integer[][][] dp) {
        if (index == n) {
            if (count == target) {
                return 0;
            } else {
                return (int) 1e9;
            }
        }

        if (count > target) {
            return (int) 1e9;
        }

        if (dp[index][count][0] != null) {
            int min = (int) 1e9;
            for(int i=0; i<k; ++i){
                if(dp[index][count][i] != null){
                    min = Math.min(min, dp[index][count][i]);
                }
            }

            if(min != (int)1e9){
                return min;
            }
        }

        int minCost = (int) 1e9;
        for (int i = 0; i < k; i++) {
            int cost = costs[index][i] + solve(costs, n, k, target, index + 1, count + 1, dp);
            minCost = Math.min(minCost, cost);
            dp[index][count + 1][i] = cost;
        }

        return minCost;
    }
}