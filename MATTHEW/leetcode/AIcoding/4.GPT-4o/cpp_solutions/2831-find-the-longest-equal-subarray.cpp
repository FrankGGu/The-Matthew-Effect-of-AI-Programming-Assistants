class Solution {
public:
    int longestEqualSubarray(vector<int>& nums, int k) {
        int maxLength = 0, left = 0, count = 0;
        unordered_map<int, int> freq;

        for (int right = 0; right < nums.size(); ++right) {
            freq[nums[right]]++;
            count = max(count, freq[nums[right]]);

            while (right - left + 1 - count > k) {
                freq[nums[left]]--;
                left++;
            }

            maxLength = max(maxLength, right - left + 1);
        }

        return maxLength;
    }
};