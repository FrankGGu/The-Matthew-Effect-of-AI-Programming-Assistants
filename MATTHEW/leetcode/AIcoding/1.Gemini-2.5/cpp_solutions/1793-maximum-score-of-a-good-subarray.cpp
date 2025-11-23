#include <vector>
#include <algorithm> // For std::min and std::max

class Solution {
public:
    int maximumScore(std::vector<int>& nums, int k) {
        int n = nums.size();
        int left = k;
        int right = k;
        int min_val = nums[k];
        int max_score = nums[k];

        while (left > 0 || right < n - 1) {
            if (left == 0) {
                // Must expand right
                right++;
                min_val = std::min(min_val, nums[right]);
            } else if (right == n - 1) {
                // Must expand left
                left--;
                min_val = std::min(min_val, nums[left]);
            } else if (nums[left - 1] > nums[right + 1]) {
                // Expand left if the left neighbor is larger
                left--;
                min_val = std::min(min_val, nums[left]);
            } else {
                // Expand right if the right neighbor is larger or equal
                right++;
                min_val = std::min(min_val, nums[right]);
            }
            max_score = std::max(max_score, min_val * (right - left + 1));
        }

        return max_score;
    }
};