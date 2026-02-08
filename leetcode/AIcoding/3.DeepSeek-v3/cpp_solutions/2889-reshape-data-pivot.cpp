#include <vector>
#include <string>
#include <unordered_map>
#include <set>

using namespace std;

vector<vector<string>> pivotTable(vector<vector<string>>& data, string row, string column, string value) {
    unordered_map<string, unordered_map<string, string>> pivot;
    set<string> rowSet;
    set<string> colSet;

    int rowIdx = -1, colIdx = -1, valIdx = -1;
    if (!data.empty()) {
        vector<string>& headers = data[0];
        for (int i = 0; i < headers.size(); ++i) {
            if (headers[i] == row) rowIdx = i;
            else if (headers[i] == column) colIdx = i;
            else if (headers[i] == value) valIdx = i;
        }
    }

    if (rowIdx == -1 || colIdx == -1 || valIdx == -1) {
        return {};
    }

    for (int i = 1; i < data.size(); ++i) {
        vector<string>& entry = data[i];
        string r = entry[rowIdx];
        string c = entry[colIdx];
        string v = entry[valIdx];
        pivot[r][c] = v;
        rowSet.insert(r);
        colSet.insert(c);
    }

    vector<string> cols(colSet.begin(), colSet.end());
    sort(cols.begin(), cols.end());

    vector<vector<string>> result;
    vector<string> header;
    header.push_back(row);
    header.insert(header.end(), cols.begin(), cols.end());
    result.push_back(header);

    vector<string> rows(rowSet.begin(), rowSet.end());
    sort(rows.begin(), rows.end());

    for (const string& r : rows) {
        vector<string> newRow;
        newRow.push_back(r);
        for (const string& c : cols) {
            newRow.push_back(pivot[r][c]);
        }
        result.push_back(newRow);
    }

    return result;
}