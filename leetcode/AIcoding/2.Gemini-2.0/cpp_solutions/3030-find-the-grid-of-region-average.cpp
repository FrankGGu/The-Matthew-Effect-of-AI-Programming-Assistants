#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<vector<int>> resultGrid(vector<vector<int>>& image, int threshold) {
        int m = image.size();
        int n = image[0].size();
        vector<vector<int>> regions(m, vector<int>(n, 0));
        vector<vector<int>> sums(m, vector<int>(n, 0));
        vector<vector<int>> counts(m, vector<int>(n, 0));
        vector<vector<int>> res(m, vector<int>(n, -1));

        for (int i = 0; i < m - 2; ++i) {
            for (int j = 0; j < n - 2; ++j) {
                bool valid = true;
                for (int x = i; x < i + 3; ++x) {
                    for (int y = j; y < j + 2; ++y) {
                        if (abs(image[x][y] - image[x][y + 1]) > threshold) {
                            valid = false;
                            break;
                        }
                    }
                    if (!valid) break;
                    for (int y = j; y < j + 3; ++y) {
                        if (abs(image[x][y] - image[x + 1][y]) > threshold) {
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
                            regions[x][y] = 1;
                            sum += image[x][y];
                        }
                    }
                    int avg = sum / 9;
                    for (int x = i; x < i + 3; ++x) {
                        for (int y = j; y < j + 3; ++y) {
                            sums[x][y] += avg;
                            counts[x][y]++;
                        }
                    }
                }
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (counts[i][j] > 0) {
                    res[i][j] = sums[i][j] / counts[i][j];
                } else {
                    res[i][j] = image[i][j];
                }
            }
        }

        return res;
    }
};