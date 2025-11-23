#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> melt(vector<vector<string>>& df, vector<string>& cols, string& var_name, string& value_name) {
        vector<vector<string>> result;
        if (df.empty()) return result;

        int id_cols = df[0].size() - cols.size();
        vector<string> id_columns;
        for (int i = 0; i < id_cols; ++i) {
            id_columns.push_back(df[0][i]);
        }

        vector<string> header = id_columns;
        header.push_back(var_name);
        header.push_back(value_name);
        result.push_back(header);

        for (int i = 1; i < df.size(); ++i) {
            for (const auto& col : cols) {
                vector<string> row;
                for (int j = 0; j < id_cols; ++j) {
                    row.push_back(df[i][j]);
                }
                row.push_back(col);
                row.push_back(df[i][id_cols + distance(df[0].begin(), find(df[0].begin(), df[0].end(), col))]);
                result.push_back(row);
            }
        }

        return result;
    }
};