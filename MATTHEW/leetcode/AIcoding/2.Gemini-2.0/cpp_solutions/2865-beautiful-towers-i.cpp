#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumSumOfHeights(vector<int>& maxHeights) {
        int n = maxHeights.size();
        long long maxSum = 0;

        for (int i = 0; i < n; ++i) {
            long long currentSum = maxHeights[i];
            int currentHeight = maxHeights[i];

            for (int j = i - 1; j >= 0; --j) {
                currentHeight = min(currentHeight, maxHeights[j]);
                currentSum += currentHeight;
            }

            currentHeight = maxHeights[i];
            for (int j = i + 1; j < n; ++j) {
                currentHeight = min(currentHeight, maxHeights[j]);
                currentSum += currentHeight;
            }

            maxSum = max(maxSum, currentSum);
        }

        return maxSum;
    }
};