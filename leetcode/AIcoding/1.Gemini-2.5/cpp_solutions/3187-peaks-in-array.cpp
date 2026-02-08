#include <vector>

class Solution {
public:
    int countPeaks(std::vector<int>& nums) {
        int n = nums.size();
        if (n < 3) {
            return 0;
        }

        int peaks = 0;
        for (int i = 1; i < n - 1; ++i) {
            if (nums[i] > nums[i - 1] && nums[i] > nums[i + 1]) {
                peaks++;
            }
        }
        return peaks;
    }
};