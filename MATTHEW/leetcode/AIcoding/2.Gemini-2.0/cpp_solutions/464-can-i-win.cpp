#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool canIWin(int maxChoosableInteger, int desiredTotal) {
        if (desiredTotal <= 0) return true;
        if ((1 + maxChoosableInteger) * maxChoosableInteger / 2 < desiredTotal) return false;

        unordered_map<int, bool> memo;
        vector<bool> used(maxChoosableInteger + 1, false);

        function<bool(int, int)> solve = [&](int currentTotal, int state) {
            if (memo.count(state)) return memo[state];

            for (int i = 1; i <= maxChoosableInteger; ++i) {
                if (!used[i]) {
                    if (currentTotal + i >= desiredTotal) {
                        memo[state] = true;
                        return true;
                    }
                    used[i] = true;
                    if (!solve(currentTotal + i, state | (1 << i))) {
                        used[i] = false;
                        memo[state] = true;
                        return true;
                    }
                    used[i] = false;
                }
            }

            memo[state] = false;
            return false;
        };

        return solve(0, 0);
    }
};