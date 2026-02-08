class Solution {
public:
    vector<vector<int>> maxScoreIndices(vector<int>& nums) {
        int n = nums.size();
        vector<int> left(n + 1, 0), right(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            left[i + 1] = left[i] + (nums[i] == 0);
        }
        for (int i = n - 1; i >= 0; --i) {
            right[i] = right[i + 1] + (nums[i] == 1);
        }
        int maxScore = 0;
        for (int i = 0; i <= n; ++i) {
            maxScore = max(maxScore, left[i] + right[i]);
        }
        vector<vector<int>> result;
        for (int i = 0; i <= n; ++i) {
            if (left[i] + right[i] == maxScore) {
                result.push_back({i, maxScore});
            }
        }
        return result;
    }
};