#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<std::string>> displayTable(std::vector<std::vector<std::string>>& orders) {
        std::map<int, std::map<std::string, int>> tableData;
        std::set<std::string> foodItems;

        for (const auto& order : orders) {
            int tableNumber = std::stoi(order[1]);
            const std::string& foodItem = order[2];

            tableData[tableNumber][foodItem]++;
            foodItems.insert(foodItem);
        }

        std::vector<std::vector<std::string>> result;

        std::vector<std::string> header;
        header.push_back("Table");
        for (const auto& item : foodItems) {
            header.push_back(item);
        }
        result.push_back(header);

        for (auto const& [tableNum, foodCounts] : tableData) {
            std::vector<std::string> row;
            row.push_back(std::to_string(tableNum));
            for (const auto& item : foodItems) {
                if (foodCounts.count(item)) {
                    row.push_back(std::to_string(foodCounts.at(item)));
                } else {
                    row.push_back("0");
                }
            }
            result.push_back(row);
        }

        return result;
    }
};