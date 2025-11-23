class Solution {
public:
    int maximizeScore(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int score = 0;

        for (int i = 0; i < k; ++i) {
            score += nums[i];
        }

        return score;
    }
};