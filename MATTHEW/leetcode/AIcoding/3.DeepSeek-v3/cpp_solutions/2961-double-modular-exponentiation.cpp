class Solution {
public:
    vector<int> getGoodIndices(vector<vector<int>>& variables, int target) {
        vector<int> res;
        for (int i = 0; i < variables.size(); ++i) {
            int a = variables[i][0];
            int b = variables[i][1];
            int c = variables[i][2];
            int m = variables[i][3];
            int x = 1;
            for (int j = 0; j < b; ++j) {
                x = (x * a) % 10;
            }
            int y = 1;
            for (int j = 0; j < c; ++j) {
                y = (y * x) % m;
            }
            if (y == target) {
                res.push_back(i);
            }
        }
        return res;
    }
};