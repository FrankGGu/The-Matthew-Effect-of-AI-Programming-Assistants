#include <vector>
#include <unordered_map>
#include <unordered_set>

class Solution {
public:
    std::vector<int> findingUsersActiveMinutes(std::vector<std::vector<int>>& logs, int k) {
        std::unordered_map<int, std::unordered_set<int>> user_minutes;
        for (const auto& log : logs) {
            user_minutes[log[0]].insert(log[1]);
        }

        std::vector<int> result(k, 0);
        for (const auto& pair : user_minutes) {
            int uam = pair.second.size();
            if (uam > 0 && uam <= k) {
                result[uam - 1]++;
            }
        }

        return result;
    }
};