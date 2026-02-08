class Solution {
public:
    int maximumScore(vector<int>& nums, int k) {
        int n = nums.size();
        int maxScore = 0;

        for (int i = k; i < n; i++) {
            int minValue = nums[k];
            for (int j = k; j <= i; j++) {
                minValue = min(minValue, nums[j]);
            }
            maxScore = max(maxScore, minValue * (i - k + 1));
        }

        return maxScore;
    }
};