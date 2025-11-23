#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>

using namespace std;

vector<int> findingUsersActiveMinutes(vector<vector<int>>& logs, int k) {
    unordered_map<int, unordered_set<int>> userMinutes;
    for (const auto& log : logs) {
        userMinutes[log[0]].insert(log[1]);
    }

    vector<int> result(k, 0);
    for (const auto& entry : userMinutes) {
        int activeMinutes = entry.second.size();
        if (activeMinutes <= k) {
            result[activeMinutes - 1]++;
        }
    }

    return result;
}