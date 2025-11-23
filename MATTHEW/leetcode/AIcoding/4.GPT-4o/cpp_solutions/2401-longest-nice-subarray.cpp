class Solution {
public:
    int longestNiceSubarray(vector<int>& nums) {
        int n = nums.size();
        int left = 0, maxLength = 0;
        unordered_set<int> seen;

        for (int right = 0; right < n; ++right) {
            while (seen.count(nums[right])) {
                seen.erase(nums[left]);
                left++;
            }
            seen.insert(nums[right]);
            maxLength = max(maxLength, right - left + 1);
        }

        return maxLength;
    }
};