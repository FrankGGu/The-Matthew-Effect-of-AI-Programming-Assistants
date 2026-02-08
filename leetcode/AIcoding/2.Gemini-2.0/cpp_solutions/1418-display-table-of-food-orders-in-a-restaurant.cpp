#include <vector>
#include <string>
#include <algorithm>
#include <map>
#include <set>

using namespace std;

class Solution {
public:
    vector<vector<string>> displayTable(vector<vector<string>>& orders) {
        set<string> foodItems;
        set<int> tableNumbers;
        map<int, map<string, int>> tableOrders;

        for (auto& order : orders) {
            int tableNumber = stoi(order[1]);
            string foodItem = order[2];

            foodItems.insert(foodItem);
            tableNumbers.insert(tableNumber);

            if (tableOrders.find(tableNumber) == tableOrders.end()) {
                tableOrders[tableNumber] = map<string, int>();
            }
            tableOrders[tableNumber][foodItem]++;
        }

        vector<vector<string>> result;
        vector<string> header = {"Table"};
        for (auto& foodItem : foodItems) {
            header.push_back(foodItem);
        }
        result.push_back(header);

        vector<int> sortedTableNumbers(tableNumbers.begin(), tableNumbers.end());
        sort(sortedTableNumbers.begin(), sortedTableNumbers.end());

        for (int tableNumber : sortedTableNumbers) {
            vector<string> row = {to_string(tableNumber)};
            for (auto& foodItem : foodItems) {
                if (tableOrders[tableNumber].find(foodItem) != tableOrders[tableNumber].end()) {
                    row.push_back(to_string(tableOrders[tableNumber][foodItem]));
                } else {
                    row.push_back("0");
                }
            }
            result.push_back(row);
        }

        return result;
    }
};