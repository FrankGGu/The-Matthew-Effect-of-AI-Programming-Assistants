#include <unordered_map>

class Solution {
public:
    int leastOpsExpressTarget(int x, int target) {
        std::unordered_map<int, std::pair<int, int>> memo;
        return solve(x, target, memo).first - 1;
    }

private:
    std::pair<int, int> solve(int x, int target, std::unordered_map<int, std::pair<int, int>>& memo) {
        if (target == 0) {
            return {0, 0};
        }
        if (memo.count(target)) {
            return memo[target];
        }

        int p = 0;
        long long power = 1;
        while (power < target) {
            power *= x;
            p++;
        }

        if (power == target) {
            memo[target] = {p, 0};
            return {p, 0};
        }

        std::pair<int, int> res;
        int plus = solve(x, power - target, memo).first + p;
        int minus = solve(x, target - power / x, memo).first + p - 1;
        res.first = std::min(plus, minus);

        memo[target] = res;
        return res;
    }
};