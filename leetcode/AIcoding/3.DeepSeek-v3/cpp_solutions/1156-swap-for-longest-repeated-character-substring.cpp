class Solution {
public:
    int maxRepOpt1(string text) {
        vector<pair<char, int>> groups;
        int n = text.size();
        for (int i = 0; i < n; ) {
            char c = text[i];
            int cnt = 0;
            while (i < n && text[i] == c) {
                cnt++;
                i++;
            }
            groups.emplace_back(c, cnt);
        }

        int res = 0;
        for (int i = 0; i < groups.size(); ++i) {
            res = max(res, groups[i].second);
            if (i + 2 < groups.size() && groups[i].first == groups[i + 2].first) {
                int total = groups[i].second + groups[i + 2].second;
                if (groups.size() > 3) {
                    res = max(res, total + 1);
                } else {
                    res = max(res, total);
                }
            }
        }

        unordered_map<char, int> count;
        for (auto& p : groups) {
            count[p.first] += p.second;
        }

        for (int i = 0; i < groups.size(); ++i) {
            if (count[groups[i].first] > groups[i].second) {
                res = max(res, groups[i].second + 1);
            }
        }

        return res;
    }
};