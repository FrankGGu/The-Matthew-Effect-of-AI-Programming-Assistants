#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findLargestOutlier(vector<int>& nums) {
        if (nums.size() < 3) {
            return -1;
        }

        vector<int> sortedNums = nums;
        sort(sortedNums.begin(), sortedNums.end());

        int q1 = sortedNums[nums.size() / 4];
        int q3 = sortedNums[nums.size() * 3 / 4];
        int iqr = q3 - q1;
        int lowerBound = q1 - 1.5 * iqr;
        int upperBound = q3 + 1.5 * iqr;

        int largestOutlier = -1;
        for (int num : nums) {
            if (num < lowerBound || num > upperBound) {
                largestOutlier = max(largestOutlier, num);
            }
        }

        return largestOutlier;
    }
};