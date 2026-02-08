#include <vector>

using namespace std;

class Solution {
public:
    int countSubmatrices(vector<vector<int>>& matrix, int k) {
        int m = matrix.size();
        int n = matrix[0].size();
        int count = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                for (int r = i; r < m; ++r) {
                    for (int c = j; c < n; ++c) {
                        int sum = 0;
                        for (int row = i; row <= r; ++row) {
                            for (int col = j; col <= c; ++col) {
                                sum += matrix[row][col];
                            }
                        }
                        if (sum <= k) {
                            count++;
                        }
                    }
                }
            }
        }

        return count;
    }
};