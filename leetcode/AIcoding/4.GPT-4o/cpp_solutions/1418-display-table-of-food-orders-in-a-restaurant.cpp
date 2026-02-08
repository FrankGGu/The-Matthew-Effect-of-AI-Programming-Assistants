#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>
#include <set>
#include <sstream>

using namespace std;

vector<vector<string>> displayTable(vector<vector<string>>& orders) {
    unordered_map<string, unordered_map<string, int>> foodCount;
    set<string> tables;

    for (const auto& order : orders) {
        const string& table = order[1];
        const string& food = order[2];
        foodCount[food][table]++;
        tables.insert(table);
    }

    vector<string> foodItems;
    for (const auto& food : foodCount) {
        foodItems.push_back(food.first);
    }
    sort(foodItems.begin(), foodItems.end());

    vector<string> tableList(tables.begin(), tables.end());
    sort(tableList.begin(), tableList.end());

    vector<vector<string>> result;
    result.push_back({"Table"}); 
    result.back().insert(result.back().end(), foodItems.begin(), foodItems.end());

    for (const string& table : tableList) {
        vector<string> row;
        row.push_back(table);
        for (const string& food : foodItems) {
            row.push_back(to_string(foodCount[food][table]));
        }
        result.push_back(row);
    }

    return result;
}