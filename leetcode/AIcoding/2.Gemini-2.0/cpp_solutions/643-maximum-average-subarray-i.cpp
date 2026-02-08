#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    double findMaxAverage(vector<int>& nums, int k) {
        int n = nums.size();
        double sum = accumulate(nums.begin(), nums.begin() + k, 0.0);
        double maxSum = sum;

        for (int i = k; i < n; ++i) {
            sum += nums[i] - nums[i - k];
            maxSum = max(maxSum, sum);
        }

        return maxSum / k;
    }
};