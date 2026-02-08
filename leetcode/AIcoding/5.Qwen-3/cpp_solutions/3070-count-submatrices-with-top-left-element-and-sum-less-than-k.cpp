#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int countSubmatrices(vector<vector<int>>& matrix, int k) {
        int n = matrix.size();
        int m = matrix[0].size();
        int count = 0;

        for (int i = 0; i < n; ++i) {
            vector<int> row(m, 0);
            for (int j = i; j < n; ++j) {
                for (int k = 0; k < m; ++k) {
                    row[k] += matrix[j][k];
                }

                int currentSum = 0;
                for (int l = 0; l < m; ++l) {
                    currentSum += row[l];
                    if (currentSum < k) {
                        count++;
                    }
                }
            }
        }

        return count;
    }
};