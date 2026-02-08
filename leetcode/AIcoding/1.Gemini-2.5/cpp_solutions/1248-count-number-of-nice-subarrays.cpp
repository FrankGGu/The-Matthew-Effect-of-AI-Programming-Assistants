class Solution {
public:
    long long countAtMost(std::vector<int>& nums, int k) {
        if (k < 0) {
            return 0;
        }

        int n = nums.size();
        int left = 0;
        int odd_count = 0;
        long long ans = 0;

        for (int right = 0; right < n; ++right) {
            if (nums[right] % 2 != 0) {
                odd_count++;
            }

            while (odd_count > k) {
                if (nums[left] % 2 != 0) {
                    odd_count--;
                }
                left++;
            }
            ans += (right - left + 1);
        }
        return ans;
    }

    int numberOfSubarrays(std::vector<int>& nums, int k) {
        return static_cast<int>(countAtMost(nums, k) - countAtMost(nums, k - 1));
    }
};