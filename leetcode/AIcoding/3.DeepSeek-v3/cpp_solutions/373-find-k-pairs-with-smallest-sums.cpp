class Solution {
public:
    vector<vector<int>> kSmallestPairs(vector<int>& nums1, vector<int>& nums2, int k) {
        auto cmp = [&nums1, &nums2](const pair<int, int>& a, const pair<int, int>& b) {
            return nums1[a.first] + nums2[a.second] > nums1[b.first] + nums2[b.second];
        };
        priority_queue<pair<int, int>, vector<pair<int, int>>, decltype(cmp)> pq(cmp);
        vector<vector<int>> res;
        if (nums1.empty() || nums2.empty() || k == 0) return res;
        for (int i = 0; i < nums1.size() && i < k; ++i) {
            pq.push({i, 0});
        }
        while (k-- > 0 && !pq.empty()) {
            auto idx = pq.top();
            pq.pop();
            res.push_back({nums1[idx.first], nums2[idx.second]});
            if (idx.second + 1 < nums2.size()) {
                pq.push({idx.first, idx.second + 1});
            }
        }
        return res;
    }
};