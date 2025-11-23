#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<vector<string>> melt(vector<vector<string>>& df, string id_vars, string value_vars) {
        map<string, int> columnIndices;
        for (int i = 0; i < df[0].size(); ++i) {
            columnIndices[df[0][i]] = i;
        }

        vector<vector<string>> result;
        int idIndex = columnIndices[id_vars];
        int valueIndex = columnIndices[value_vars];

        for (int i = 1; i < df.size(); ++i) {
            vector<string> row;
            row.push_back(df[i][idIndex]);
            row.push_back(df[i][valueIndex]);
            result.push_back(row);
        }

        return result;
    }
};