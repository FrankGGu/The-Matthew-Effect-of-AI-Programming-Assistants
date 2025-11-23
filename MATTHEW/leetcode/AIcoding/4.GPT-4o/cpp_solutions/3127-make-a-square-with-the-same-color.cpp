class Solution {
public:
    bool canMakeSquare(vector<int>& matchsticks) {
        int totalLength = accumulate(matchsticks.begin(), matchsticks.end(), 0);
        if (totalLength % 4 != 0) return false;
        int sideLength = totalLength / 4;
        vector<int> sides(4, 0);
        return backtrack(matchsticks, 0, sides, sideLength);
    }

    bool backtrack(vector<int>& matchsticks, int index, vector<int>& sides, int sideLength) {
        if (index == matchsticks.size()) {
            return sides[0] == sides[1] && sides[1] == sides[2] && sides[2] == sides[3];
        }
        for (int i = 0; i < 4; i++) {
            if (sides[i] + matchsticks[index] <= sideLength) {
                sides[i] += matchsticks[index];
                if (backtrack(matchsticks, index + 1, sides, sideLength)) return true;
                sides[i] -= matchsticks[index];
            }
        }
        return false;
    }
};