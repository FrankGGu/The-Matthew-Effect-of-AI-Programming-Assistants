class Solution {
public:
    bool isPrintable(vector<vector<int>>& targetGrid) {
        int m = targetGrid.size(), n = targetGrid[0].size();
        vector<int> left(61, m), right(61, -1), top(61, n), bottom(61, -1);

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int color = targetGrid[i][j];
                if (color == 0) continue;
                left[color] = min(left[color], j);
                right[color] = max(right[color], j);
                top[color] = min(top[color], i);
                bottom[color] = max(bottom[color], i);
            }
        }

        vector<int> color(61);
        iota(color.begin(), color.end(), 0);
        for (int k = 1; k <= 60; ++k) {
            if (left[k] <= right[k]) {
                for (int i = top[k]; i <= bottom[k]; ++i) {
                    for (int j = left[k]; j <= right[k]; ++j) {
                        if (targetGrid[i][j] != k && targetGrid[i][j] != 0) {
                            return false;
                        }
                    }
                }
            }
        }

        return true;
    }
};