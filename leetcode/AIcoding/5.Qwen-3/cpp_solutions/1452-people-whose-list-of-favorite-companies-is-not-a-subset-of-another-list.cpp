#include <iostream>
#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> peopleIndexes(vector<vector<string>>& favoriteCompanies) {
        int n = favoriteCompanies.size();
        vector<unordered_set<string>> sets(n);
        for (int i = 0; i < n; ++i) {
            sets[i].insert(favoriteCompanies[i].begin(), favoriteCompanies[i].end());
        }

        vector<int> result;
        for (int i = 0; i < n; ++i) {
            bool isNotSubset = true;
            for (int j = 0; j < n; ++j) {
                if (i != j && sets[i].size() <= sets[j].size()) {
                    bool isSubset = true;
                    for (const string& s : sets[i]) {
                        if (sets[j].find(s) == sets[j].end()) {
                            isSubset = false;
                            break;
                        }
                    }
                    if (isSubset) {
                        isNotSubset = false;
                        break;
                    }
                }
            }
            if (isNotSubset) {
                result.push_back(i);
            }
        }
        return result;
    }
};