class Solution {
public:
    int countSubarrays(vector<int>& nums) {
        int n = nums.size();
        vector<int> left(n), right(n);

        for (int i = 0; i < n; ++i) {
            if (i == 0 || nums[i] >= nums[i - 1]) {
                left[i] = (i == 0 ? 0 : left[i - 1]) + 1;
            } else {
                left[i] = 1;
            }
        }

        for (int i = n - 1; i >= 0; --i) {
            if (i == n - 1 || nums[i] <= nums[i + 1]) {
                right[i] = (i == n - 1 ? 0 : right[i + 1]) + 1;
            } else {
                right[i] = 1;
            }
        }

        int total = 0;
        for (int i = 0; i < n; ++i) {
            total += left[i] + right[i] - 1;
        }

        return total;
    }
};