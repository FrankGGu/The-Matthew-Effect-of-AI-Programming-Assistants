#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    long long minOperationsToMakeMedianK(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int median_pos = n / 2;
        long long operations = 0;

        if (nums[median_pos] == k) {
            return 0;
        } else if (nums[median_pos] < k) {
            operations += k - nums[median_pos];
            for (int i = median_pos + 1; i < n; ++i) {
                if (nums[i] < k) {
                    operations += k - nums[i];
                } else {
                    break;
                }
            }
        } else {
            operations += nums[median_pos] - k;
            for (int i = median_pos - 1; i >= 0; --i) {
                if (nums[i] > k) {
                    operations += nums[i] - k;
                } else {
                    break;
                }
            }
        }

        return operations;
    }
};