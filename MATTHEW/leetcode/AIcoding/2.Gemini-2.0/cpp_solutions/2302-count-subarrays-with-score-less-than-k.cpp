class Solution {
public:
    long long countSubarrays(vector<int>& nums, long long k) {
        long long count = 0;
        long long currentSum = 0;
        int left = 0;
        for (int right = 0; right < nums.size(); ++right) {
            currentSum += nums[right];
            while ((currentSum * (right - left + 1)) >= k && left <= right) {
                currentSum -= nums[left];
                left++;
            }
            count += (right - left + 1);
        }
        return count;
    }
};