class Solution {
public:
    int leastOpsExpressTarget(int x, int target) {
        unordered_map<int, int> memo;
        return dp(x, target, memo) - 1;
    }

private:
    int dp(int x, int target, unordered_map<int, int>& memo) {
        if (target == 0) return 0;
        if (target == 1) return 1;
        if (memo.count(target)) return memo[target];

        long product = x;
        int k = 0;
        while (product < target) {
            product *= x;
            k++;
        }

        int ans;
        if (product == target) {
            ans = k;
        } else {
            ans = dp(x, product - target, memo) + k + 1;
            if (product / x < target) {
                ans = min(ans, dp(x, target - product / x, memo) + k);
            }
        }
        memo[target] = ans;
        return ans;
    }
};