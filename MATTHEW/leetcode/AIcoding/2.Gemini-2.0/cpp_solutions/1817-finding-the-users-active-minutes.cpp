#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> findingUsersActiveMinutes(vector<vector<int>>& logs, int k) {
        unordered_map<int, unordered_set<int>> user_minutes;
        for (auto& log : logs) {
            int user_id = log[0];
            int minute = log[1];
            user_minutes[user_id].insert(minute);
        }

        vector<int> result(k, 0);
        for (auto& pair : user_minutes) {
            int uam = pair.second.size();
            if (uam <= k) {
                result[uam - 1]++;
            }
        }

        return result;
    }
};