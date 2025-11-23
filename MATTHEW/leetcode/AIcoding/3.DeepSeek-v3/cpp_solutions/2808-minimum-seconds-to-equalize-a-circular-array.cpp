class Solution {
public:
    int minimumSeconds(vector<int>& nums) {
        unordered_map<int, vector<int>> pos;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            pos[nums[i]].push_back(i);
        }

        int res = INT_MAX;
        for (auto& [num, indices] : pos) {
            int max_gap = 0;
            int m = indices.size();
            for (int i = 0; i < m; ++i) {
                int gap = (indices[(i + 1) % m] - indices[i] - 1 + n) % n;
                max_gap = max(max_gap, gap);
            }
            int seconds = (max_gap + 1) / 2;
            res = min(res, seconds);
        }
        return res;
    }
};