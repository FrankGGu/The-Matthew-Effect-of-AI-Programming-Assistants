class Solution {
public:
    vector<vector<int>> findSolution(CustomFunction& customfunction, int z) {
        vector<vector<int>> res;
        int x = 1, y = 1000;
        while (x <= 1000 && y >= 1) {
            int val = customfunction.f(x, y);
            if (val == z) {
                res.push_back({x, y});
                x++;
                y--;
            } else if (val < z) {
                x++;
            } else {
                y--;
            }
        }
        return res;
    }
};