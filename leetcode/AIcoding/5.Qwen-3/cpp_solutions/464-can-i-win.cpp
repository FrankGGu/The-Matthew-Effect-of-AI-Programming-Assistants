#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool canIWin(int maxChoosableInteger, int desiredTotal) {
        if (desiredTotal <= 0) return true;
        if ((maxChoosableInteger * (maxChoosableInteger + 1)) / 2 < desiredTotal) return false;

        unordered_map<int, bool> memo;
        return dfs(maxChoosableInteger, desiredTotal, 0, memo);
    }

private:
    bool dfs(int maxNum, int target, int state, unordered_map<int, bool>& memo) {
        if (memo.count(state)) return memo[state];

        for (int i = 1; i <= maxNum; ++i) {
            if ((state & (1 << i)) == 0) {
                if (target - i <= 0 || !dfs(maxNum, target - i, state | (1 << i), memo)) {
                    memo[state] = true;
                    return true;
                }
            }
        }

        memo[state] = false;
        return false;
    }
};