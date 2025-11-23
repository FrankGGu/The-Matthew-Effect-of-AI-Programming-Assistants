#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<vector<int>> pivotTable(vector<vector<string>>& table) {
        map<string, map<string, int>> data;
        for (const auto& row : table) {
            string user = row[0];
            string product = row[1];
            int amount = stoi(row[2]);
            data[user][product] += amount;
        }

        vector<vector<int>> result;
        vector<string> headers = {"user"};
        for (const auto& [product, _] : data.begin()->second) {
            headers.push_back(product);
        }
        result.push_back(headers);

        for (const auto& [user, products] : data) {
            vector<int> row;
            row.push_back(stoi(user));
            for (const auto& [product, amount] : products) {
                row.push_back(amount);
            }
            result.push_back(row);
        }

        return result;
    }
};