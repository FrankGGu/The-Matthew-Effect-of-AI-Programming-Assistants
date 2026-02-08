class Solution {
public:
    int minArea(vector<vector<char>>& image, int x, int y) {
        int m = image.size(), n = image[0].size();
        int left = y, right = y, top = x, bottom = x;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (image[i][j] == '1') {
                    left = min(left, j);
                    right = max(right, j);
                    top = min(top, i);
                    bottom = max(bottom, i);
                }
            }
        }
        return (right - left + 1) * (bottom - top + 1);
    }
};