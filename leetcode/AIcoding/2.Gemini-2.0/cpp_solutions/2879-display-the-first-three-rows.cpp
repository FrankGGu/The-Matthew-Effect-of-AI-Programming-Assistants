#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> displayTable(vector<vector<string>>& orders) {
        map<int, map<string, int>> tableOrders;
        set<string> foodItems;

        for (auto& order : orders) {
            int tableNum = stoi(order[1]);
            string foodItem = order[2];

            tableOrders[tableNum][foodItem]++;
            foodItems.insert(foodItem);
        }

        vector<vector<int>> result;
        vector<string> header = {"Table"};
        for (auto& foodItem : foodItems) {
            header.push_back(foodItem);
        }
        vector<int> temp;
        result.push_back(vector<int>(header.size()));
        for (int i = 0; i < header.size(); ++i) {
            result[0][i] = -1;
        }

        for (int i = 0; i < header.size(); ++i) {
            if (i == 0) {
                continue;
            }

        }

        vector<string> header_str;
        header_str.push_back("Table");
        for(auto& foodItem : foodItems){
            header_str.push_back(foodItem);
        }

        vector<vector<string>> result_str;
        result_str.push_back(header_str);

        for (auto& tableOrder : tableOrders) {
            vector<string> row;
            row.push_back(to_string(tableOrder.first));

            for (int i = 1; i < header_str.size(); ++i) {
                string foodItem = header_str[i];
                if (tableOrder.second.count(foodItem)) {
                    row.push_back(to_string(tableOrder.second[foodItem]));
                } else {
                    row.push_back("0");
                }
            }
            result_str.push_back(row);
        }

        vector<vector<int>> final_result;

        return {};
    }
};