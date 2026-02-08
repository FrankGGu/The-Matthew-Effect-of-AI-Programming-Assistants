#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> displayTable(vector<string>& orders) {
        vector<vector<int>> result;
        vector<string> tables;
        vector<string> foods;
        vector<vector<int>> tableFoodCount;

        for (const string& order : orders) {
            size_t spacePos = order.find(' ');
            string tableNum = order.substr(0, spacePos);
            string food = order.substr(spacePos + 1);

            if (find(tables.begin(), tables.end(), tableNum) == tables.end()) {
                tables.push_back(tableNum);
            }

            if (find(foods.begin(), foods.end(), food) == foods.end()) {
                foods.push_back(food);
            }
        }

        sort(tables.begin(), tables.end());
        sort(foods.begin(), foods.end());

        tableFoodCount.resize(tables.size(), vector<int>(foods.size(), 0));

        for (const string& order : orders) {
            size_t spacePos = order.find(' ');
            string tableNum = order.substr(0, spacePos);
            string food = order.substr(spacePos + 1);

            int tableIndex = find(tables.begin(), tables.end(), tableNum) - tables.begin();
            int foodIndex = find(foods.begin(), foods.end(), food) - foods.begin();
            tableFoodCount[tableIndex][foodIndex]++;
        }

        vector<string> header = {"Table"};
        for (const string& food : foods) {
            header.push_back(food);
        }
        result.push_back(header);

        for (int i = 0; i < tables.size(); ++i) {
            vector<int> row;
            row.push_back(stoi(tables[i]));
            for (int j = 0; j < foods.size(); ++j) {
                row.push_back(tableFoodCount[i][j]);
            }
            result.push_back(row);
        }

        return result;
    }
};