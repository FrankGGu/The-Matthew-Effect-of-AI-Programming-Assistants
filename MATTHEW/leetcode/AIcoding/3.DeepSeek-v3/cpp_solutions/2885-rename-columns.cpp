#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<vector<string>> renameColumns(vector<vector<string>>& data, vector<string>& names) {
        if (data.empty()) return data;

        unordered_map<int, string> colMap;
        for (int i = 0; i < names.size(); ++i) {
            colMap[i] = names[i];
        }

        vector<vector<string>> result;
        for (auto& row : data) {
            vector<string> newRow;
            for (int i = 0; i < row.size(); ++i) {
                if (colMap.find(i) != colMap.end()) {
                    newRow.push_back(colMap[i]);
                } else {
                    newRow.push_back(row[i]);
                }
            }
            result.push_back(newRow);
        }

        return result;
    }
};