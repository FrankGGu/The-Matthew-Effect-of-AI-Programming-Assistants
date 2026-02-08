class Solution {
public:
    vector<int> closestEqual(vector<int>& nums, vector<vector<int>>& queries) {
        int n = nums.size();
        unordered_map<int, vector<int>> indices;
        for (int i = 0; i < n; ++i) {
            indices[nums[i]].push_back(i);
        }
        vector<int> result;
        for (auto& query : queries) {
            int x = query[0], y = query[1];
            if (indices.count(x) == 0) {
                result.push_back(-1);
                continue;
            }
            const auto& idxs = indices[x];
            auto it = lower_bound(idxs.begin(), idxs.end(), y);
            int closest = -1;
            if (it != idxs.end()) {
                closest = *it;
            }
            if (it != idxs.begin()) {
                int leftClosest = *(prev(it));
                if (closest == -1 || abs(leftClosest - y) <= abs(closest - y)) {
                    closest = leftClosest;
                }
            }
            result.push_back(closest == -1 ? -1 : closest);
        }
        return result;
    }
};