#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<int> findMissingAndRepeatedValues(vector<vector<int>>& grid) {
        int n = grid.size();
        long long sum = 0;
        long long sqSum = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                sum += grid[i][j];
                sqSum += (long long)grid[i][j] * grid[i][j];
            }
        }

        long long expectedSum = (long long)n * n * (n * n + 1) / 2;
        long long expectedSqSum = (long long)n * n * (n * n + 1) * (2 * n * n + 1) / 6;

        long long diffSum = expectedSum - sum;
        long long diffSqSum = expectedSqSum - sqSum;

        long long sumRepeatedMissing = diffSqSum / diffSum;
        long long repeated = (sumRepeatedMissing - diffSum) / 2;
        long long missing = sumRepeatedMissing - repeated;

        return {(int)repeated, (int)missing};
    }
};