class Solution {
public:
    bool makesquare(vector<int>& matchsticks) {
        int total = accumulate(matchsticks.begin(), matchsticks.end(), 0);
        if (total % 4 != 0) return false;
        int side = total / 4;
        vector<int> sides(4, 0);
        sort(matchsticks.rbegin(), matchsticks.rend());
        return dfs(matchsticks, sides, 0, side);
    }

    bool dfs(vector<int>& matchsticks, vector<int>& sides, int index, int side) {
        if (index == matchsticks.size()) {
            return sides[0] == side && sides[1] == side && sides[2] == side;
        }
        for (int i = 0; i < 4; i++) {
            if (sides[i] + matchsticks[index] <= side) {
                sides[i] += matchsticks[index];
                if (dfs(matchsticks, sides, index + 1, side)) {
                    return true;
                }
                sides[i] -= matchsticks[index];
            }
        }
        return false;
    }
};