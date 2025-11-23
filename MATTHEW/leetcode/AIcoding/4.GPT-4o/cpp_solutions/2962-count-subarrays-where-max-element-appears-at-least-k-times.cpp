class Solution {
public:
    long long countSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        unordered_map<int, int> freq;
        long long result = 0;
        int left = 0;

        for (int right = 0; right < n; ++right) {
            freq[nums[right]]++;

            while (freq[nums[right]] >= k) {
                result += n - right;
                freq[nums[left]]--;
                if (freq[nums[left]] == 0) {
                    freq.erase(nums[left]);
                }
                left++;
            }
        }

        return result;
    }
};