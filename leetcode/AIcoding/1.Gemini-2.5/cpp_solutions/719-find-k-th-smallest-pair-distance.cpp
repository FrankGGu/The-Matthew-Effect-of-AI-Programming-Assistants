#include <vector>
#include <algorithm>

class Solution {
public:
    int smallestDistancePair(std::vector<int>& nums, int k) {
        std::sort(nums.begin(), nums.end());
        int n = nums.size();
        int low = 0;
        int high = nums[n - 1] - nums[0];
        int ans = high;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (countPairs(nums, mid) >= k) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }

private:
    int countPairs(const std::vector<int>& nums, int dist) {
        int count = 0;
        int n = nums.size();
        int left = 0;
        for (int right = 0; right < n; ++right) {
            while (nums[right] - nums[left] > dist) {
                left++;
            }
            count += right - left;
        }
        return count;
    }
};