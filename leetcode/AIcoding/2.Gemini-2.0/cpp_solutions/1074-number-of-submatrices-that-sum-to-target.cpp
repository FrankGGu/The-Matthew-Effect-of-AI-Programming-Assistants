#include <vector>

using namespace std;

class Solution {
public:
    int numSubmatrixSumTarget(vector<vector<int>>& matrix, int target) {
        int n = matrix.size();
        int m = matrix[0].size();
        int count = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = 1; j < m; ++j) {
                matrix[i][j] += matrix[i][j - 1];
            }
        }

        for (int c1 = 0; c1 < m; ++c1) {
            for (int c2 = c1; c2 < m; ++c2) {
                vector<int> sum(n, 0);
                for (int i = 0; i < n; ++i) {
                    sum[i] = matrix[i][c2] - (c1 > 0 ? matrix[i][c1 - 1] : 0);
                }

                for (int i = 0; i < n; ++i) {
                    int currentSum = 0;
                    for (int j = i; j < n; ++j) {
                        currentSum += sum[j];
                        if (currentSum == target) {
                            count++;
                        }
                    }
                }
            }
        }

        return count;
    }
};