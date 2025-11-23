#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numSubmat(vector<vector<int>>& matrix) {
        int m = matrix.size();
        int n = matrix[0].size();
        int count = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (matrix[i][j] == 1) {
                    int min_width = n;
                    for (int k = i; k < m; ++k) {
                        min_width = min(min_width, j);
                        while (min_width >= 0 && matrix[k][min_width] == 1) {
                            min_width--;
                        }
                        count += (j - min_width);
                    }
                }
            }
        }

        return count;
    }
};