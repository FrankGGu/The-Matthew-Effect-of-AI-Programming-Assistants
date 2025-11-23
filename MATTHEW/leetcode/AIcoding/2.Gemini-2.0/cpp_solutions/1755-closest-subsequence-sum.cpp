#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minAbsDifference(vector<int>& nums, int goal) {
        int n = nums.size();
        vector<int> leftSums, rightSums;

        function<void(int, int, vector<int>&, int)> generateSums = 
            [&](int start, int end, vector<int>& sums, int currentSum) {
            if (start > end) {
                sums.push_back(currentSum);
                return;
            }
            generateSums(start + 1, end, sums, currentSum + nums[start]);
            generateSums(start + 1, end, sums, currentSum);
        };

        generateSums(0, n / 2, leftSums, 0);
        generateSums(n / 2 + 1, n - 1, rightSums, 0);

        sort(rightSums.begin(), rightSums.end());

        int minDiff = INT_MAX;
        for (int leftSum : leftSums) {
            int target = goal - leftSum;
            auto it = lower_bound(rightSums.begin(), rightSums.end(), target);
            if (it != rightSums.end()) {
                minDiff = min(minDiff, abs(leftSum + *it - goal));
            }
            if (it != rightSums.begin()) {
                it--;
                minDiff = min(minDiff, abs(leftSum + *it - goal));
            }
        }
        return minDiff;
    }
};