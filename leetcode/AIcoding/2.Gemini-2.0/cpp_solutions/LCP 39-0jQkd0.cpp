#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool check(vector<vector<int>>& source, vector<vector<int>>& target, int rowShift, int colShift) {
        int n = source.size();
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (source[i][j] == 1 && target[i + rowShift][j + colShift] != 1) {
                    return false;
                }
            }
        }
        return true;
    }

    int largestOverlap(vector<vector<int>>& img1, vector<vector<int>>& img2) {
        int n = img1.size();
        vector<vector<int>> shifted_img2(3 * n, vector<int>(3 * n, 0));
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                shifted_img2[i + n][j + n] = img2[i][j];
            }
        }

        int maxOverlap = 0;
        for (int rowShift = 0; rowShift < 2 * n - 1; ++rowShift) {
            for (int colShift = 0; colShift < 2 * n - 1; ++colShift) {
                int overlap = 0;
                for (int i = 0; i < n; ++i) {
                    for (int j = 0; j < n; ++j) {
                        if (img1[i][j] == 1 && shifted_img2[i + rowShift][j + colShift] == 1) {
                            overlap++;
                        }
                    }
                }
                maxOverlap = max(maxOverlap, overlap);
            }
        }

        return maxOverlap;
    }
};