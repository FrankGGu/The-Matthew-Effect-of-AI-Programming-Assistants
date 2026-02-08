class Solution {
    public int leastOpsExpressTarget(int x, int target) {
        Map<String, Integer> memo = new HashMap<>();
        return dfs(x, target, memo);
    }

    private int dfs(int x, int target, Map<String, Integer> memo) {
        String key = x + "," + target;
        if (memo.containsKey(key)) {
            return memo.get(key);
        }
        if (target == 0) {
            return 0;
        }
        if (target == 1) {
            return 1;
        }
        if (x == target) {
            return 0;
        }

        long product = x;
        int k = 0;
        while (product < target) {
            product *= x;
            k++;
        }

        int res;
        if (product == target) {
            res = k;
        } else {
            int option1 = Integer.MAX_VALUE;
            if (product - target < target) {
                option1 = k + 1 + dfs(x, (int)(product - target), memo);
            }
            int option2 = dfs(x, (int)(target - (product / x)), memo) + (k == 0 ? 2 : k);
            res = Math.min(option1, option2);
        }

        memo.put(key, res);
        return res;
    }
}