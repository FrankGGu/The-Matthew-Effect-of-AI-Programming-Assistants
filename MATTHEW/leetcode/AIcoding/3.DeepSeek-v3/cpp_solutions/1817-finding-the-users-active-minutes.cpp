#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> findingUsersActiveMinutes(vector<vector<int>>& logs, int k) {
        unordered_map<int, unordered_set<int>> userToMinutes;
        for (const auto& log : logs) {
            int user = log[0];
            int time = log[1];
            userToMinutes[user].insert(time);
        }

        vector<int> answer(k, 0);
        for (const auto& entry : userToMinutes) {
            int uam = entry.second.size();
            if (uam >= 1 && uam <= k) {
                answer[uam - 1]++;
            }
        }

        return answer;
    }
};