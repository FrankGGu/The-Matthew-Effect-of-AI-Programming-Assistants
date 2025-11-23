#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<vector<int>> accountSummaryTable(vector<vector<int>>& accounts) {
        map<int, int> balanceMap;
        for (const auto& account : accounts) {
            int userId = account[0];
            int amount = account[1];
            balanceMap[userId] += amount;
        }

        vector<vector<int>> result;
        for (const auto& pair : balanceMap) {
            result.push_back({pair.first, pair.second});
        }

        return result;
    }
};