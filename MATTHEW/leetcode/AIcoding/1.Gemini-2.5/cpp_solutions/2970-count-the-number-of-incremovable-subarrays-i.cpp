class Solution {
public:
    int incremovableSubarrayCount(std::vector<int>& nums) {
        int n = nums.size();
        int count = 0;

        for (int i = 0; i < n; ++i) { // Starting index of the subarray to remove
            for (int j = i; j < n; ++j) { // Ending index of the subarray to remove
                bool is_strictly_increasing = true;

                // Check the prefix part: nums[0...i-1]
                for (int k = 0; k < i - 1; ++k) {
                    if (nums[k] >= nums[k+1]) {
                        is_strictly_increasing = false;
                        break;
                    }
                }
                if (!is_strictly_increasing) {
                    continue; 
                }

                // Check the suffix part: nums[j+1...n-1]
                for (int k = j + 1; k < n - 1; ++k) {
                    if (nums[k] >= nums[k+1]) {
                        is_strictly_increasing = false;
                        break;
                    }
                }
                if (!is_strictly_increasing) {
                    continue;
                }

                // Check the connection between the prefix and suffix
                // This applies only if both prefix (nums[0...i-1]) and suffix (nums[j+1...n-1]) exist
                if (i > 0 && j < n - 1) {
                    if (nums[i-1] >= nums[j+1]) {
                        is_strictly_increasing = false;
                    }
                }

                if (is_strictly_increasing) {
                    count++;
                }
            }
        }
        return count;
    }
};