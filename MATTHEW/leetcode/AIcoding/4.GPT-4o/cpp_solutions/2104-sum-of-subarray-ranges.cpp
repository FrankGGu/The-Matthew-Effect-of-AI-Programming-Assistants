class Solution {
public:
    long long subarrayRanges(vector<int>& nums) {
        long long totalRange = 0;
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            int minVal = nums[i], maxVal = nums[i];
            for (int j = i; j < n; ++j) {
                minVal = min(minVal, nums[j]);
                maxVal = max(maxVal, nums[j]);
                totalRange += (maxVal - minVal);
            }
        }

        return totalRange;
    }
};