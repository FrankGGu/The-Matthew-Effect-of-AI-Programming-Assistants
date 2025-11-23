#include <iostream>
#include <vector>
#include <algorithm>
#include <set>

using namespace std;

class Solution {
public:
    int maxSumSubmatrix(vector<vector<int>>& matrix, int k) {
        int rows = matrix.size();
        int cols = matrix[0].size();
        int maxSum = INT_MIN;

        for (int left = 0; left < cols; ++left) {
            vector<int> temp(rows, 0);
            for (int right = left; right < cols; ++right) {
                for (int i = 0; i < rows; ++i) {
                    temp[i] += matrix[i][right];
                }

                set<int> prefixSums;
                prefixSums.insert(0);
                int currentSum = 0;
                int currentMax = INT_MIN;

                for (int i = 0; i < rows; ++i) {
                    currentSum += temp[i];
                    auto it = prefixSums.lower_bound(currentSum - k);
                    if (it != prefixSums.end()) {
                        currentMax = max(currentMax, currentSum - *it);
                    }
                    prefixSums.insert(currentSum);
                }

                maxSum = max(maxSum, currentMax);
            }
        }

        return maxSum;
    }
};