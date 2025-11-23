#include <iostream>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int integerReplacement(int n) {
        unordered_map<int, int> memo;
        return helper(n, memo);
    }

private:
    int helper(int n, unordered_map<int, int>& memo) {
        if (n == 1) return 0;
        if (memo.count(n)) return memo[n];

        int res;
        if (n % 2 == 0) {
            res = 1 + helper(n / 2, memo);
        } else {
            res = 1 + min(helper(n - 1, memo), helper(n + 1, memo));
        }

        memo[n] = res;
        return res;
    }
};