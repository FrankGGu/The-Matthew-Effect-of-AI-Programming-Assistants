class Solution {
public:
    vector<int> maximizeXor(vector<int>& nums, vector<vector<int>>& queries) {
        int n = nums.size(), m = queries.size();
        vector<int> ans(m);
        vector<pair<int, pair<int, int>>> q(m);
        sort(nums.begin(), nums.end());

        for (int i = 0; i < m; ++i) {
            q[i] = {queries[i][1], {queries[i][0], i}};
        }
        sort(q.begin(), q.end());

        int idx = 0, max_xor = 0;
        multiset<int> num_set;

        for (auto& query : q) {
            while (idx < n && nums[idx] <= query.first) {
                num_set.insert(nums[idx]);
                ++idx;
            }
            if (!num_set.empty()) {
                max_xor = 0;
                for (int num : num_set) {
                    max_xor = max(max_xor, query.second.first ^ num);
                }
            }
            ans[query.second.second] = max_xor;
        }

        return ans;
    }
};