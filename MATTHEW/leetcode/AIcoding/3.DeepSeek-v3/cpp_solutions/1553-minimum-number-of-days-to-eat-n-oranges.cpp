class Solution {
public:
    unordered_map<int, int> memo;

    int minDays(int n) {
        if (n <= 1) {
            return n;
        }
        if (memo.count(n)) {
            return memo[n];
        }
        int res = 1 + min(n % 2 + minDays(n / 2), n % 3 + minDays(n / 3));
        memo[n] = res;
        return res;
    }
};