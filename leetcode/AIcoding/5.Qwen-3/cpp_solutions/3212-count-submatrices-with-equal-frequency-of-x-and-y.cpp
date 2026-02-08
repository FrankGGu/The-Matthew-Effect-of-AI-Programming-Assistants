#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countSubmatrices(vector<vector<char>>& grid) {
        int n = grid.size();
        int m = grid[0].size();
        int count = 0;

        for (int i = 0; i < n; ++i) {
            vector<int> rowSum(m, 0);
            for (int j = i; j < n; ++j) {
                for (int k = 0; k < m; ++k) {
                    rowSum[k] += (grid[j][k] == 'X' ? 1 : (grid[j][k] == 'Y' ? -1 : 0));
                }

                unordered_map<int, int> prefixCount;
                prefixCount[0] = 1;
                int currentSum = 0;
                for (int k = 0; k < m; ++k) {
                    currentSum += rowSum[k];
                    if (prefixCount.find(currentSum) != prefixCount.end()) {
                        count += prefixCount[currentSum];
                    }
                    prefixCount[currentSum]++;
                }
            }
        }

        return count;
    }
};