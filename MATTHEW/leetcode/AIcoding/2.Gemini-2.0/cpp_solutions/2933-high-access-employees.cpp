#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> findHighAccessEmployees(vector<vector<string>>& access_times) {
        unordered_map<string, vector<int>> employee_times;
        for (auto& access : access_times) {
            employee_times[access[0]].push_back(stoi(access[1]));
        }

        vector<string> result;
        for (auto& [employee, times] : employee_times) {
            sort(times.begin(), times.end());
            for (int i = 0; i < times.size() - 2; ++i) {
                if (times[i + 2] - times[i] < 100) {
                    result.push_back(employee);
                    break;
                }
            }
        }

        return result;
    }
};