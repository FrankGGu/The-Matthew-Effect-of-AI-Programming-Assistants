#include <vector>
#include <string>
#include <map>
#include <algorithm>
#include <set>

class Solution {
public:
    std::vector<std::string> alertNames(std::vector<std::string>& keyName, std::vector<std::string>& keyTime) {
        std::map<std::string, std::vector<int>> employee_times;

        for (size_t i = 0; i < keyName.size(); ++i) {
            std::string name = keyName[i];
            std::string time_str = keyTime[i];

            int hour = std::stoi(time_str.substr(0, 2));
            int minute = std::stoi(time_str.substr(3, 2));
            int total_minutes = hour * 60 + minute;

            employee_times[name].push_back(total_minutes);
        }

        std::set<std::string> alert_employees;

        for (auto const& [name, times_list] : employee_times) {
            std::vector<int> sorted_times = times_list;
            std::sort(sorted_times.begin(), sorted_times.end());

            if (sorted_times.size() < 3) {
                continue;
            }

            for (size_t i = 0; i <= sorted_times.size() - 3; ++i) {
                if (sorted_times[i+2] - sorted_times[i] <= 60) {
                    alert_employees.insert(name);
                    break; 
                }
            }
        }

        return std::vector<std::string>(alert_employees.begin(), alert_employees.end());
    }
};