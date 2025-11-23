class Solution {
public:
    vector<vector<int>> findFarmland(vector<vector<int>>& land) {
        vector<vector<int>> result;
        int rows = land.size(), cols = land[0].size();

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (land[i][j] == 1) {
                    int x1 = i, y1 = j;
                    while (i < rows && land[i][j] == 1) i++;
                    while (j < cols && land[x1][j] == 1) j++;
                    result.push_back({x1, y1, i - 1, j - 1});
                }
            }
        }

        return result;
    }
};