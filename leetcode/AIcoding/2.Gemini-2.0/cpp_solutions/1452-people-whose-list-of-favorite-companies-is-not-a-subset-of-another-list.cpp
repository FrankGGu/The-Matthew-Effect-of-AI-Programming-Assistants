#include <vector>
#include <string>
#include <algorithm>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> peopleIndexes(vector<vector<string>>& favoriteCompanies) {
        int n = favoriteCompanies.size();
        vector<unordered_set<string>> companySets(n);
        for (int i = 0; i < n; ++i) {
            for (const string& company : favoriteCompanies[i]) {
                companySets[i].insert(company);
            }
        }

        vector<int> result;
        for (int i = 0; i < n; ++i) {
            bool isSubset = false;
            for (int j = 0; j < n; ++j) {
                if (i == j) continue;
                if (companySets[j].size() >= companySets[i].size()) {
                    bool allFound = true;
                    for (const string& company : favoriteCompanies[i]) {
                        if (companySets[j].find(company) == companySets[j].end()) {
                            allFound = false;
                            break;
                        }
                    }
                    if (allFound) {
                        isSubset = true;
                        break;
                    }
                }
            }
            if (!isSubset) {
                result.push_back(i);
            }
        }
        return result;
    }
};