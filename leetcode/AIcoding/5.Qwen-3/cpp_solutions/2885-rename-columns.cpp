#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<vector<string>> renameColumns(vector<vector<string>> users) {
        if (users.empty()) return {};
        vector<vector<string>> result;
        for (const auto& row : users) {
            vector<string> newRow;
            newRow.push_back(row[1]);
            newRow.push_back(row[0]);
            result.push_back(newRow);
        }
        return result;
    }
};