class Solution {
public:
    vector<int> lexicographicallySmallestArray(vector<int>& nums, int limit) {
        int n = nums.size();
        vector<pair<int, int>> numWithIndex;
        for (int i = 0; i < n; ++i) {
            numWithIndex.emplace_back(nums[i], i);
        }
        sort(numWithIndex.begin(), numWithIndex.end());

        vector<vector<pair<int, int>>> groups;
        for (int i = 0; i < n; ++i) {
            if (i == 0 || numWithIndex[i].first - numWithIndex[i-1].first > limit) {
                groups.emplace_back();
            }
            groups.back().push_back(numWithIndex[i]);
        }

        vector<int> res(n);
        for (auto &group : groups) {
            vector<int> indices;
            for (auto &p : group) {
                indices.push_back(p.second);
            }
            sort(indices.begin(), indices.end());
            for (int i = 0; i < group.size(); ++i) {
                res[indices[i]] = group[i].first;
            }
        }
        return res;
    }
};