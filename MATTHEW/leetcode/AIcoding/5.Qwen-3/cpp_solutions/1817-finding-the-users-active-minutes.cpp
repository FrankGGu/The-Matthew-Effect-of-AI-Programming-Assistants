#include <iostream>
#include <vector>
#include <unordered_map>
#include <set>

using namespace std;

class Solution {
public:
    int findingUsersActiveMinutes(vector<vector<int>>& logs, int k) {
        unordered_map<int, set<int>> userActivity;
        for (const auto& log : logs) {
            userActivity[log[0]].insert(log[1]);
        }

        vector<int> result(k, 0);
        for (const auto& pair : userActivity) {
            int minutes = pair.second.size();
            if (minutes > 0 && minutes <= k) {
                result[minutes - 1]++;
            }
        }

        return result[0];
    }
};