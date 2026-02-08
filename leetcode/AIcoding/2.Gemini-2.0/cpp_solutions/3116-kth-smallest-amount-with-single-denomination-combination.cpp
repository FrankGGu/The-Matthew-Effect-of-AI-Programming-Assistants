#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long kthSmallest(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        long long low = 0, high = (long long)nums[0] * k;
        while (low < high) {
            long long mid = low + (high - low) / 2;
            long long count = 0;
            for (int num : nums) {
                count += mid / num;
            }
            if (count < k) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }
};