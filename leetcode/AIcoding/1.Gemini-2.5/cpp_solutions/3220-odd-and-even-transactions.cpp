#include <vector>
#include <string>
#include <map>
#include <utility>

class Solution {
public:
    std::vector<std::vector<std::string>> oddAndEvenTransactions(const std::vector<std::vector<std::string>>& transactions) {
        std::map<std::string, std::pair<int, int>> daily_sums;

        for (const auto& t : transactions) {
            // Assuming transaction format is {id_string, amount_string, date_string}
            // and date_string is "YYYY-MM-DD"
            const std::string& date_str = t[2];
            int amount = std::stoi(t[1]);
            int day = std::stoi(date_str.substr(8, 2));

            if (day % 2 != 0) { // Odd day
                daily_sums[date_str].first += amount;
            } else { // Even day
                daily_sums[date_str].second += amount;
            }
        }

        std::vector<std::vector<std::string>> result;
        for (const auto& pair : daily_sums) {
            result.push_back({
                pair.first,
                std::to_string(pair.second.first),
                std::to_string(pair.second.second)
            });
        }

        return result;
    }
};