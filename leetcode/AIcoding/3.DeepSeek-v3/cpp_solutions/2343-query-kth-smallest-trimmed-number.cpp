class Solution {
public:
    vector<int> smallestTrimmedNumbers(vector<string>& nums, vector<vector<int>>& queries) {
        vector<int> res;
        for (auto& q : queries) {
            int k = q[0], trim = q[1];
            vector<pair<string, int>> trimmed;
            for (int i = 0; i < nums.size(); ++i) {
                string s = nums[i];
                if (trim < s.size()) {
                    s = s.substr(s.size() - trim);
                }
                trimmed.emplace_back(s, i);
            }
            sort(trimmed.begin(), trimmed.end(), [](const pair<string, int>& a, const pair<string, int>& b) {
                if (a.first == b.first) return a.second < b.second;
                return a.first < b.first;
            });
            res.push_back(trimmed[k - 1].second);
        }
        return res;
    }
};