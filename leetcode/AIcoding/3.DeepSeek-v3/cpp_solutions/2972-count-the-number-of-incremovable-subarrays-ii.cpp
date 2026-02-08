class Solution {
public:
    long long incremovableSubarrayCount(vector<int>& nums) {
        int n = nums.size();
        int left = 0;
        while (left + 1 < n && nums[left] < nums[left + 1]) {
            left++;
        }
        if (left == n - 1) {
            return (long long)n * (n + 1) / 2;
        }
        long long res = left + 2;
        int right = n - 1;
        while (right > 0 && nums[right - 1] < nums[right]) {
            right--;
            res += left + 2;
        }
        for (int i = right; i < n; ++i) {
            if (left >= 0 && nums[left] >= nums[i]) {
                left--;
                i--;
                continue;
            }
            res += left + 2;
        }
        return res;
    }
};