#include <unordered_map>

using namespace std;

class Solution {
public:
    int minDays(int n) {
        unordered_map<int, int> memo;
        function<int(int)> solve = [&](int k) {
            if (k == 0) return 0;
            if (memo.count(k)) return memo[k];

            int ans = 1 + min(k % 2 + solve(k / 2), k % 3 + solve(k / 3));
            memo[k] = ans;
            return ans;
        };

        return solve(n);
    }
};