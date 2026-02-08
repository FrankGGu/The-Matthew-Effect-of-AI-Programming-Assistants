#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numSubmatrixSumTarget(vector<vector<int>>& matrix, int target) {
        int rows = matrix.size();
        int cols = matrix[0].size();
        int result = 0;

        for (int left = 0; left < cols; ++left) {
            vector<int> temp(rows, 0);
            for (int right = left; right < cols; ++right) {
                for (int i = 0; i < rows; ++i) {
                    temp[i] += matrix[i][right];
                }

                unordered_map<int, int> prefixSumCount;
                prefixSumCount[0] = 1;
                int currentSum = 0;
                for (int i = 0; i < rows; ++i) {
                    currentSum += temp[i];
                    if (prefixSumCount.find(currentSum - target) != prefixSumCount.end()) {
                        result += prefixSumCount[currentSum - target];
                    }
                    prefixSumCount[currentSum]++;
                }
            }
        }

        return result;
    }
};