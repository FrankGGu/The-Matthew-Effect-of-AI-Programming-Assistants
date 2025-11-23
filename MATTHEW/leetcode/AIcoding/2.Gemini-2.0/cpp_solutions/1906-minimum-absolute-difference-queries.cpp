class Solution {
public:
    vector<int> minDifference(vector<int>& nums, vector<vector<int>>& queries) {
        int n = nums.size();
        vector<vector<int>> pos(101);
        for (int i = 0; i < n; ++i) {
            pos[nums[i]].push_back(i);
        }

        vector<int> ans;
        for (auto& query : queries) {
            int left = query[0];
            int right = query[1];
            int minDiff = INT_MAX;
            int prev = -1;
            for (int i = 1; i <= 100; ++i) {
                auto& p = pos[i];
                auto it = lower_bound(p.begin(), p.end(), left);
                if (it != p.end() && *it <= right) {
                    if (prev != -1) {
                        minDiff = min(minDiff, i - prev);
                    }
                    prev = i;
                }
            }
            if (minDiff == INT_MAX) {
                ans.push_back(-1);
            } else {
                ans.push_back(minDiff);
            }
        }
        return ans;
    }
};