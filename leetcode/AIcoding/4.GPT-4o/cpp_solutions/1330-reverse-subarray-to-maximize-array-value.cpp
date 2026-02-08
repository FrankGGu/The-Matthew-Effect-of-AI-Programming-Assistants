class Solution {
public:
    int maximumValue(vector<int>& nums) {
        int n = nums.size();
        int maxValue = *max_element(nums.begin(), nums.end());

        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                reverse(nums.begin() + i, nums.begin() + j + 1);
                maxValue = max(maxValue, *max_element(nums.begin(), nums.end()));
                reverse(nums.begin() + i, nums.begin() + j + 1);
            }
        }

        return maxValue;
    }
};