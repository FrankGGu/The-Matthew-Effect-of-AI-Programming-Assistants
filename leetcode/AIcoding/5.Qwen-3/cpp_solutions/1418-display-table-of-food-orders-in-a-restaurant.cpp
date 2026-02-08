#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <sstream>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> displayTable(vector<vector<string>>& orders) {
        map<string, set<string>> tableToFood;
        set<string> foods;
        set<string> tables;

        for (const auto& order : orders) {
            string table = order[1];
            string food = order[2];
            tableToFood[table].insert(food);
            foods.insert(food);
            tables.insert(table);
        }

        vector<string> foodList(foods.begin(), foods.end());
        sort(foodList.begin(), foodList.end());

        vector<string> tableList(tables.begin(), tables.end());
        sort(tableList.begin(), tableList.end());

        vector<vector<string>> result;
        vector<string> header = {"Table"};
        for (const auto& food : foodList) {
            header.push_back(food);
        }
        result.push_back(header);

        for (const auto& table : tableList) {
            vector<string> row;
            row.push_back(table);
            for (const auto& food : foodList) {
                int count = 0;
                if (tableToFood[table].find(food) != tableToFood[table].end()) {
                    count = 1;
                }
                row.push_back(to_string(count));
            }
            result.push_back(row);
        }

        return result;
    }
};