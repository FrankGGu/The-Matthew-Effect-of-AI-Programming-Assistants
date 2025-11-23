class Solution {
public:
    int maximumTripletValue(vector<int>& nums) {
        int n = nums.size();
        int maxValue = 0;
        int maxPrefix = nums[0];

        for (int j = 1; j < n - 1; ++j) {
            maxPrefix = max(maxPrefix, nums[j - 1]);
            int currentValue = maxPrefix + nums[j] - nums[j + 1];
            maxValue = max(maxValue, currentValue);
        }

        return maxValue;
    }
};