class Solution {
public:
    int countSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        long long sum = 0;
        int count = 0;
        int left = 0;

        for (int right = 0; right < n; ++right) {
            sum += nums[right];
            while (sum * (right - left + 1) >= k) {
                sum -= nums[left];
                left++;
            }
            count += right - left + 1;
        }

        return count;
    }
};