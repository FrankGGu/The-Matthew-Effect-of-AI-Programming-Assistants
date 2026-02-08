#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int matrixScore(vector<vector<int>>& A) {
        int m = A.size();
        int n = A[0].size();

        for (int i = 0; i < m; ++i) {
            if (A[i][0] == 0) {
                for (int j = 0; j < n; ++j) {
                    A[i][j] ^= 1;
                }
            }
        }

        for (int j = 1; j < n; ++j) {
            int count_0 = 0;
            int count_1 = 0;
            for (int i = 0; i < m; ++i) {
                if (A[i][j] == 0) {
                    count_0++;
                } else {
                    count_1++;
                }
            }
            if (count_0 > count_1) {
                for (int i = 0; i < m; ++i) {
                    A[i][j] ^= 1;
                }
            }
        }

        int score = 0;
        for (int i = 0; i < m; ++i) {
            int row_score = 0;
            for (int j = 0; j < n; ++j) {
                row_score = row_score * 2 + A[i][j];
            }
            score += row_score;
        }

        return score;
    }
};