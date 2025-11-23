class Solution {
public:
    long long maximumSubarraySum(vector<int>& nums, int k) {
        unordered_map<int, int> freq;
        long long max_sum = 0;
        long long current_sum = 0;
        int left = 0;

        for (int right = 0; right < nums.size(); ++right) {
            freq[nums[right]]++;
            current_sum += nums[right];

            if (right - left + 1 == k) {
                if (freq.size() == k) {
                    max_sum = max(max_sum, current_sum);
                }
                freq[nums[left]]--;
                if (freq[nums[left]] == 0) {
                    freq.erase(nums[left]);
                }
                current_sum -= nums[left];
                left++;
            }
        }

        return max_sum;
    }
};