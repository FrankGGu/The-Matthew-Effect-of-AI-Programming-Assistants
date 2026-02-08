class Solution {
public:
    long long countSubarrays(vector<int>& nums, int k) {
        int maxVal = *max_element(nums.begin(), nums.end());
        long long count = 0;
        for (int i = 0; i < nums.size(); ++i) {
            int maxCount = 0;
            for (int j = i; j < nums.size(); ++j) {
                if (nums[j] == maxVal) {
                    maxCount++;
                }
                if (maxCount >= k) {
                    count++;
                }
            }
        }
        return count;
    }
};