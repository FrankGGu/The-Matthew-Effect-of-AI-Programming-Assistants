class Solution {
public:
    int findMinimumCost(vector<int>& nums) {
        int maxNum = *max_element(nums.begin(), nums.end());
        vector<int> freq(maxNum + 1, 0);

        for (int num : nums) {
            freq[num]++;
        }

        vector<int> dp(maxNum + 1, 0);
        dp[1] = freq[1];

        for (int i = 2; i <= maxNum; ++i) {
            dp[i] = min(dp[i - 1] + freq[i], dp[i - 2] + freq[i] * i);
        }

        return dp[maxNum];
    }
};