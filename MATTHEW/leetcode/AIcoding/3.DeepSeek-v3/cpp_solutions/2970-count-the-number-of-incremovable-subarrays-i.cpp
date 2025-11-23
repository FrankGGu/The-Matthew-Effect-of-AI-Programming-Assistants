class Solution {
public:
    int incremovableSubarrayCount(vector<int>& nums) {
        int n = nums.size();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                bool valid = true;
                int prev = -1;
                for (int k = 0; k < n; ++k) {
                    if (k >= i && k <= j) continue;
                    if (nums[k] <= prev) {
                        valid = false;
                        break;
                    }
                    prev = nums[k];
                }
                if (valid) count++;
            }
        }
        return count;
    }
};