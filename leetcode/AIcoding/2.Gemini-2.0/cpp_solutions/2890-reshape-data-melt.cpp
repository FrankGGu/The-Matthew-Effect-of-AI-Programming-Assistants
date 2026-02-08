#include <vector>
#include <string>
#include <algorithm>

using namespace std;

vector<vector<string>> melt(vector<vector<string>>& content, vector<string>& id_vars) {
    vector<vector<string>> result;
    vector<int> id_indices;
    vector<int> value_indices;

    for (int i = 0; i < content[0].size(); ++i) {
        bool is_id = false;
        for (const string& id_var : id_vars) {
            if (content[0][i] == id_var) {
                is_id = true;
                id_indices.push_back(i);
                break;
            }
        }
        if (!is_id) {
            value_indices.push_back(i);
        }
    }

    for (int i = 1; i < content.size(); ++i) {
        for (int value_index : value_indices) {
            vector<string> row;
            for (int id_index : id_indices) {
                row.push_back(content[i][id_index]);
            }
            row.push_back(content[0][value_index]);
            row.push_back(content[i][value_index]);
            result.push_back(row);
        }
    }

    return result;
}