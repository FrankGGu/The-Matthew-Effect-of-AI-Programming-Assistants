#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool makesquare(vector<int>& matchsticks) {
        if (matchsticks.size() < 4) return false;
        long long sum = accumulate(matchsticks.begin(), matchsticks.end(), 0LL);
        if (sum % 4 != 0) return false;
        long long side = sum / 4;
        sort(matchsticks.rbegin(), matchsticks.rend());
        vector<int> sides(4, 0);
        return dfs(matchsticks, sides, 0, side);
    }

private:
    bool dfs(vector<int>& matchsticks, vector<int>& sides, int index, long long target) {
        if (index == matchsticks.size()) {
            return sides[0] == target && sides[1] == target && sides[2] == target && sides[3] == target;
        }
        for (int i = 0; i < 4; ++i) {
            if (sides[i] + matchsticks[index] <= target) {
                sides[i] += matchsticks[index];
                if (dfs(matchsticks, sides, index + 1, target)) {
                    return true;
                }
                sides[i] -= matchsticks[index];
            }
        }
        return false;
    }
};