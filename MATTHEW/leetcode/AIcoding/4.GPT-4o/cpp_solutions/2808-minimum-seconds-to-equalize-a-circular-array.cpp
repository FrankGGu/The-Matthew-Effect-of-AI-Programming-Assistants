class Solution {
public:
    int minimumSeconds(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, vector<int>> pos;
        for (int i = 0; i < n; i++) {
            pos[nums[i]].push_back(i);
        }

        int res = INT_MAX;

        for (auto& [num, indices] : pos) {
            indices.push_back(indices[0] + n); // simulate circular array
            int max_gap = 0;
            for (int i = 1; i < indices.size(); i++) {
                max_gap = max(max_gap, indices[i] - indices[i - 1]);
            }
            res = min(res, (max_gap + 1) / 2);
        }

        return res;
    }
};