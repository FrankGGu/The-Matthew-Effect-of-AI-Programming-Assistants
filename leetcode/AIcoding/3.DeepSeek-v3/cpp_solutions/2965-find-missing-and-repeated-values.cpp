class Solution {
public:
    vector<int> findMissingAndRepeatedValues(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<int> count(n * n + 1, 0);
        int repeated = -1, missing = -1;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                int num = grid[i][j];
                count[num]++;
                if (count[num] == 2) {
                    repeated = num;
                }
            }
        }

        for (int i = 1; i <= n * n; ++i) {
            if (count[i] == 0) {
                missing = i;
                break;
            }
        }

        return {repeated, missing};
    }
};