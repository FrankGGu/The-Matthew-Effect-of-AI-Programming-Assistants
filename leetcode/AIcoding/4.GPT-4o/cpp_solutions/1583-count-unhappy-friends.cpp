#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int countUnhappyFriends(int n, vector<vector<int>>& preferences, vector<vector<int>>& pairs) {
        unordered_map<int, unordered_set<int>> preferenceMap;
        for (int i = 0; i < n; ++i) {
            for (int j = 1; j < preferences[i].size(); ++j) {
                preferenceMap[i].insert(preferences[i][j]);
            }
        }

        unordered_map<int, int> partner;
        for (const auto& pair : pairs) {
            partner[pair[0]] = pair[1];
            partner[pair[1]] = pair[0];
        }

        int unhappyCount = 0;
        for (int i = 0; i < n; ++i) {
            int currentPartner = partner[i];
            for (int j : preferenceMap[i]) {
                if (j == currentPartner) break;
                if (preferenceMap[j].count(i) > 0 && partner[j] != i) {
                    unhappyCount++;
                    break;
                }
            }
        }

        return unhappyCount;
    }
};