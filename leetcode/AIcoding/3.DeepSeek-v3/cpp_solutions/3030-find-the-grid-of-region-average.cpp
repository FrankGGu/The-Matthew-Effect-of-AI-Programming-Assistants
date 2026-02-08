class Solution {
public:
    vector<vector<int>> resultGrid(vector<vector<int>>& image, int threshold) {
        int m = image.size(), n = image[0].size();
        vector<vector<int>> res(m, vector<int>(n, 0));
        vector<vector<int>> count(m, vector<int>(n, 0));

        for (int i = 0; i <= m - 3; ++i) {
            for (int j = 0; j <= n - 3; ++j) {
                bool valid = true;
                for (int x = i; x < i + 3; ++x) {
                    for (int y = j; y < j + 3; ++y) {
                        if (x > i && abs(image[x][y] - image[x-1][y]) > threshold) {
                            valid = false;
                            break;
                        }
                        if (y > j && abs(image[x][y] - image[x][y-1]) > threshold) {
                            valid = false;
                            break;
                        }
                    }
                    if (!valid) break;
                }
                if (valid) {
                    int sum = 0;
                    for (int x = i; x < i + 3; ++x) {
                        for (int y = j; y < j + 3; ++y) {
                            sum += image[x][y];
                        }
                    }
                    int avg = sum / 9;
                    for (int x = i; x < i + 3; ++x) {
                        for (int y = j; y < j + 3; ++y) {
                            res[x][y] += avg;
                            count[x][y]++;
                        }
                    }
                }
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (count[i][j] > 0) {
                    res[i][j] /= count[i][j];
                } else {
                    res[i][j] = image[i][j];
                }
            }
        }

        return res;
    }
};