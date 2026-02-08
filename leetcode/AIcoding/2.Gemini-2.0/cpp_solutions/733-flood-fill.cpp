#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> floodFill(vector<vector<int>>& image, int sr, int sc, int newColor) {
        int m = image.size();
        int n = image[0].size();
        int originalColor = image[sr][sc];

        if (originalColor == newColor) return image;

        function<void(int, int)> dfs = [&](int r, int c) {
            if (r < 0 || r >= m || c < 0 || c >= n || image[r][c] != originalColor) {
                return;
            }

            image[r][c] = newColor;
            dfs(r + 1, c);
            dfs(r - 1, c);
            dfs(r, c + 1);
            dfs(r, c - 1);
        };

        dfs(sr, sc);
        return image;
    }
};