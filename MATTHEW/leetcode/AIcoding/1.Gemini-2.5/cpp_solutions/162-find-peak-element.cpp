#include <vector>
#include <algorithm>

class Solution {
public:
    int findPeakElement(std::vector<int>& nums) {
        int left = 0;
        int right = nums.size() - 1;

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] > nums[mid + 1]) {
                // The peak is in the left half (including mid)
                right = mid;
            } else {
                // The peak is in the right half (excluding mid)
                left = mid + 1;
            }
        }

        return left;
    }
};