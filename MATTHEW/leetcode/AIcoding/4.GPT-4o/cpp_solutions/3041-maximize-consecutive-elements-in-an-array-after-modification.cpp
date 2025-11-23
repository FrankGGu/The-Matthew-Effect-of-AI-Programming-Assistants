class Solution {
public:
    int maximumConsecutive(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        int left = 0, maxLength = 0;
        for (int right = 0; right < nums.size(); right++) {
            while (nums[right] - nums[left] > k) {
                left++;
            }
            maxLength = max(maxLength, right - left + 1);
        }
        return maxLength;
    }
};