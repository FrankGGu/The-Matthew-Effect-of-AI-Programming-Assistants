#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxScore(vector<int>& cardPoints, int k) {
        int n = cardPoints.size();
        int total = 0;
        for (int i = 0; i < n; ++i) {
            total += cardPoints[i];
        }

        int windowSize = n - k;
        int currentSum = 0;
        for (int i = 0; i < windowSize; ++i) {
            currentSum += cardPoints[i];
        }

        int minSubarraySum = currentSum;
        for (int i = windowSize; i < n; ++i) {
            currentSum += cardPoints[i] - cardPoints[i - windowSize];
            minSubarraySum = min(minSubarraySum, currentSum);
        }

        return total - minSubarraySum;
    }
};