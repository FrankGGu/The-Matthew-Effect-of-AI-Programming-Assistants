class Solution {
public:
    vector<vector<int>> imageSmoother(vector<vector<int>>& img) {
        int rows = img.size();
        int cols = img[0].size();

        vector<vector<int>> result(rows, vector<int>(cols));

        for (int r = 0; r < rows; ++r) {
            for (int c = 0; c < cols; ++c) {
                int sum = 0;
                int count = 0;

                for (int nr = r - 1; nr <= r + 1; ++nr) {
                    for (int nc = c - 1; nc <= c + 1; ++nc) {
                        if (nr >= 0 && nr < rows && nc >= 0 && nc < cols) {
                            sum += img[nr][nc];
                            count++;
                        }
                    }
                }
                result[r][c] = sum / count;
            }
        }

        return result;
    }
};