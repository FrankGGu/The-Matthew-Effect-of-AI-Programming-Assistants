class Solution {
public:
    vector<int> findStableMountainIndices(vector<vector<int>>& mountain) {
        vector<int> res;
        int n = mountain.size();
        for (int i = 0; i < n; ++i) {
            bool isStable = true;
            for (int j = 0; j < mountain[i].size(); ++j) {
                int current = mountain[i][j];
                int left = (j > 0) ? mountain[i][j-1] : current;
                int right = (j < mountain[i].size() - 1) ? mountain[i][j+1] : current;
                int up = (i > 0) ? mountain[i-1][j] : current;
                int down = (i < n - 1) ? mountain[i+1][j] : current;
                if (abs(current - left) > 1 || abs(current - right) > 1 || abs(current - up) > 1 || abs(current - down) > 1) {
                    isStable = false;
                    break;
                }
            }
            if (isStable) {
                res.push_back(i);
            }
        }
        return res;
    }
};