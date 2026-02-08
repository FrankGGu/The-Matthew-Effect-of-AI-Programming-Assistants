#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int leastOpsToExpressNumber(int target, int nums) {
        unordered_map<int, int> memo;
        return dfs(target, nums, memo);
    }

    int dfs(int n, int nums, unordered_map<int, int>& memo) {
        if (n == 0) return 0;
        if (n == 1) return 1;
        if (memo.count(n)) return memo[n];

        int res = INT_MAX;
        int k = 0;
        int power = 1;
        while (power < n) {
            power *= nums;
            ++k;
        }

        if (power == n) {
            res = min(res, k);
        } else {
            res = min(res, dfs(n - power / nums, nums, memo) + k);
            res = min(res, dfs(power - n, nums, memo) + k + 1);
        }

        memo[n] = res;
        return res;
    }
};