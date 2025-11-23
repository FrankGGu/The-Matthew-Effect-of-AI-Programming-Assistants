class Solution {
public:
    int largestOverlap(vector<vector<int>>& img1, vector<vector<int>>& img2) {
        int n = img1.size();
        vector<pair<int, int>> ones1, ones2;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (img1[i][j] == 1) ones1.emplace_back(i, j);
                if (img2[i][j] == 1) ones2.emplace_back(i, j);
            }
        }

        map<pair<int, int>, int> count;
        int res = 0;
        for (const auto& [i1, j1] : ones1) {
            for (const auto& [i2, j2] : ones2) {
                int di = i2 - i1;
                int dj = j2 - j1;
                res = max(res, ++count[{di, dj}]);
            }
        }
        return res;
    }
};