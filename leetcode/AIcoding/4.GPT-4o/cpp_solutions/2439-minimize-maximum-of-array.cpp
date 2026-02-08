class Solution {
public:
    int minimizeArrayValue(vector<int>& nums) {
        long long sum = 0;
        int maxVal = 0;
        for (int i = 0; i < nums.size(); ++i) {
            sum += nums[i];
            maxVal = max(maxVal, (int)((sum + i) / (i + 1)));
        }
        return maxVal;
    }
};