class Solution {
public:
    vector<int> maxSumQueries(vector<vector<int>>& nums1, vector<vector<int>>& nums2, vector<vector<int>>& queries) {
        int n = nums1.size();
        vector<pair<int, int>> pairs(n);
        for (int i = 0; i < n; ++i) {
            pairs[i] = {nums1[i][0], nums2[i][0]};
        }
        sort(pairs.begin(), pairs.end());

        vector<int> results;
        for (const auto& q : queries) {
            int max_sum = -1;
            for (const auto& p : pairs) {
                if (p.first <= q[0] && p.second <= q[1]) {
                    max_sum = max(max_sum, p.first + p.second);
                }
            }
            results.push_back(max_sum);
        }
        return results;
    }
};