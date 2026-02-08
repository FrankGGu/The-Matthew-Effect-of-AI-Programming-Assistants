#include <vector>
#include <string>
#include <map>
#include <set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> displayTable(vector<vector<string>>& orders) {
        set<string> foodItems;
        map<int, map<string, int>> tableOrders;

        for (const auto& order : orders) {
            int tableNumber = stoi(order[1]);
            string foodItem = order[2];
            foodItems.insert(foodItem);
            tableOrders[tableNumber][foodItem]++;
        }

        vector<vector<string>> result;
        vector<string> header;
        header.push_back("Table");
        for (const auto& item : foodItems) {
            header.push_back(item);
        }
        result.push_back(header);

        for (auto& table : tableOrders) {
            vector<string> row;
            row.push_back(to_string(table.first));
            for (const auto& item : foodItems) {
                row.push_back(to_string(table.second[item]));
            }
            result.push_back(row);
        }

        return result;
    }
};