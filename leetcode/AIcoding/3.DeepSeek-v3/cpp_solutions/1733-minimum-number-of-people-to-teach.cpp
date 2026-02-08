class Solution {
public:
    int minimumTeachings(int n, vector<vector<int>>& languages, vector<vector<int>>& friendships) {
        unordered_map<int, unordered_set<int>> langMap;
        for (int i = 0; i < languages.size(); ++i) {
            for (int lang : languages[i]) {
                langMap[i + 1].insert(lang);
            }
        }

        vector<pair<int, int>> needTeach;
        for (auto& fr : friendships) {
            int u = fr[0], v = fr[1];
            bool canCommunicate = false;
            for (int l : langMap[u]) {
                if (langMap[v].count(l)) {
                    canCommunicate = true;
                    break;
                }
            }
            if (!canCommunicate) {
                needTeach.emplace_back(u, v);
            }
        }

        if (needTeach.empty()) return 0;

        unordered_set<int> uniqueUsers;
        for (auto& p : needTeach) {
            uniqueUsers.insert(p.first);
            uniqueUsers.insert(p.second);
        }

        int minTeach = INT_MAX;
        for (int l = 1; l <= n; ++l) {
            int count = 0;
            for (int u : uniqueUsers) {
                if (!langMap[u].count(l)) {
                    count++;
                }
            }
            minTeach = min(minTeach, count);
        }

        return minTeach;
    }
};