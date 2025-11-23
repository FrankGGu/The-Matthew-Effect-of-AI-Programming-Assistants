class Solution {
public:
    vector<int> peopleIndexes(vector<vector<string>>& favoriteCompanies) {
        int n = favoriteCompanies.size();
        vector<unordered_set<string>> sets;
        for (auto &list : favoriteCompanies) {
            sets.emplace_back(list.begin(), list.end());
        }
        vector<int> res;
        for (int i = 0; i < n; ++i) {
            bool isSubset = false;
            for (int j = 0; j < n; ++j) {
                if (i == j) continue;
                if (sets[j].size() < sets[i].size()) continue;
                bool allFound = true;
                for (const string &s : sets[i]) {
                    if (sets[j].find(s) == sets[j].end()) {
                        allFound = false;
                        break;
                    }
                }
                if (allFound) {
                    isSubset = true;
                    break;
                }
            }
            if (!isSubset) {
                res.push_back(i);
            }
        }
        return res;
    }
};