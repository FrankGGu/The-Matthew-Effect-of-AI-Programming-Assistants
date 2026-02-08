#include <vector>
#include <string>
#include <map>
#include <algorithm>
#include <set>

class Solution {
public:
    std::vector<std::string> highAccessEmployees(std::vector<std::vector<std::string>>& accessTimes) {
        std::map<std::string, std::vector<int>> employeeAccess;

        for (const auto& access : accessTimes) {
            std::string name = access[0];
            std::string timeStr = access[1];

            int hours = std::stoi(timeStr.substr(0, 2));
            int minutes = std::stoi(timeStr.substr(2, 2));
            int totalMinutes = hours * 60 + minutes;

            employeeAccess[name].push_back(totalMinutes);
        }

        std::set<std::string> highAccessNames;

        for (auto const& [name, times] : employeeAccess) {
            std::vector<int> currentEmployeeTimes = times;
            std::sort(currentEmployeeTimes.begin(), currentEmployeeTimes.end());

            if (currentEmployeeTimes.size() < 3) {
                continue;
            }

            int left = 0;
            for (int right = 0; right < currentEmployeeTimes.size(); ++right) {
                while (currentEmployeeTimes[right] - currentEmployeeTimes[left] >= 60) {
                    left++;
                }

                if (right - left + 1 >= 3) {
                    highAccessNames.insert(name);
                    break;
                }
            }
        }

        std::vector<std::string> result(highAccessNames.begin(), highAccessNames.end());

        return result;
    }
};