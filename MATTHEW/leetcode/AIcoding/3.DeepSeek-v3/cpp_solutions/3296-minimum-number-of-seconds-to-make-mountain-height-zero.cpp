class Solution {
public:
    int minimumSeconds(vector<int>& nums) {
        unordered_map<int, vector<int>> pos;
        for (int i = 0; i < nums.size(); ++i) {
            pos[nums[i]].push_back(i);
        }

        int res = INT_MAX;
        for (auto& [num, indices] : pos) {
            int max_gap = 0;
            for (int i = 1; i < indices.size(); ++i) {
                int gap = indices[i] - indices[i-1] - 1;
                max_gap = max(max_gap, gap);
            }
            int last_gap = (nums.size() - indices.back() - 1) + indices[0];
            max_gap = max(max_gap, last_gap);
            int seconds = (max_gap + 1) / 2;
            res = min(res, seconds);
        }
        return res;
    }
};