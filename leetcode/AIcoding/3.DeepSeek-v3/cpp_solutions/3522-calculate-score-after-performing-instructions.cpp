class Solution {
public:
    int calculateScore(vector<int>& nums, vector<vector<int>>& queries) {
        int n = nums.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int score = 0;
        for (auto& q : queries) {
            int l = q[0], r = q[1];
            int sum = prefix[r + 1] - prefix[l];
            if (sum % 2 == 0) {
                score += sum / 2;
            } else {
                score += sum / 2 - 1;
            }
        }
        return score;
    }
};