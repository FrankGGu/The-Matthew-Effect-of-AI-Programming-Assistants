#include <vector>
#include <string>
#include <unordered_set>
#include <algorithm>

using namespace std;

vector<string> peopleNotSubset(vector<string>& people, vector<vector<string>>& favoriteCompanies) {
    unordered_set<string> resultSet;
    int n = favoriteCompanies.size();

    for (int i = 0; i < n; ++i) {
        unordered_set<string> currentSet(favoriteCompanies[i].begin(), favoriteCompanies[i].end());
        bool isSubset = false;

        for (int j = 0; j < n; ++j) {
            if (i != j) {
                unordered_set<string> compareSet(favoriteCompanies[j].begin(), favoriteCompanies[j].end());
                if (includes(compareSet.begin(), compareSet.end(), currentSet.begin(), currentSet.end())) {
                    isSubset = true;
                    break;
                }
            }
        }

        if (!isSubset) {
            resultSet.insert(people[i]);
        }
    }

    return vector<string>(resultSet.begin(), resultSet.end());
}