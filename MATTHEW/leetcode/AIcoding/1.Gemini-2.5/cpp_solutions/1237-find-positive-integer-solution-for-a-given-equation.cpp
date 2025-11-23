class Solution {
public:
    vector<vector<int>> findSolution(CustomFunction& customfunction, int z) {
        vector<vector<int>> result;
        int x = 1;
        int y = 1000;

        while (x <= 1000 && y >= 1) {
            int val = customfunction.f(x, y);
            if (val == z) {
                result.push_back({x, y});
                x++;
                y--;
            } else if (val < z) {
                x++;
            } else {
                y--;
            }
        }

        return result;
    }
};