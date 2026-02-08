class Solution {
    private Map<Integer, Integer> memo = new HashMap<>();

    public int leastOpsExpressTarget(int x, int target) {
        if (target == 0) return 0;
        if (memo.containsKey(target)) return memo.get(target);

        int p = 0;
        long pow = 1;
        while (pow < target) {
            pow *= x;
            p++;
        }

        int ans;
        if (pow == target) {
            ans = p;
        } else {
            int plus = leastOpsExpressTarget(x, (int) (target - pow / x)) + p - 1;
            int minus = leastOpsExpressTarget(x, (int) (pow - target)) + p;
            ans = Math.min(plus, minus);
        }

        memo.put(target, ans);
        return ans;
    }
}