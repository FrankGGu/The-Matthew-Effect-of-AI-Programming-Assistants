#include <vector>
#include <set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSumSubmatrix(vector<vector<int>>& matrix, int k) {
        int rows = matrix.size();
        int cols = matrix[0].size();
        int maxSum = INT_MIN;

        for (int left = 0; left < cols; ++left) {
            vector<int> rowSum(rows, 0);

            for (int right = left; right < cols; ++right) {
                for (int i = 0; i < rows; ++i) {
                    rowSum[i] += matrix[i][right];
                }

                set<int> sumSet;
                sumSet.insert(0);
                int currentSum = 0;

                for (int sum : rowSum) {
                    currentSum += sum;
                    auto it = sumSet.lower_bound(currentSum - k);

                    if (it != sumSet.end()) {
                        maxSum = max(maxSum, currentSum - *it);
                    }

                    sumSet.insert(currentSum);
                }
            }
        }

        return maxSum;
    }
};