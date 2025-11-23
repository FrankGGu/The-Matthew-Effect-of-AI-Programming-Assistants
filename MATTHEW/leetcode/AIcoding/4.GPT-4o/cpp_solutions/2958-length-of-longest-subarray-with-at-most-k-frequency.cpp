class Solution {
public:
    int longestSubarray(vector<int>& nums, int k) {
        unordered_map<int, int> count;
        int left = 0, maxLength = 0;

        for (int right = 0; right < nums.size(); right++) {
            count[nums[right]]++;

            while (count.size() > k) {
                count[nums[left]]--;
                if (count[nums[left]] == 0) {
                    count.erase(nums[left]);
                }
                left++;
            }

            maxLength = max(maxLength, right - left + 1);
        }

        return maxLength;
    }
};