#include <vector>
#include <map>

using namespace std;

vector<vector<string>> pivotArray(vector<vector<string>>& data, string pivotColumn, string indexColumn, string valueColumn) {
    map<string, map<string, string>> pivotedData;

    for (auto& row : data) {
        string pivotValue = row[0];
        string indexValue = row[1];
        string valueValue = row[2];

        if (pivotColumn == "product") {
            pivotValue = row[0];
        } else if (pivotColumn == "store") {
            pivotValue = row[1];
        } else if (pivotColumn == "price") {
            pivotValue = row[2];
        }

        if (indexColumn == "product") {
            indexValue = row[0];
        } else if (indexColumn == "store") {
            indexValue = row[1];
        } else if (indexColumn == "price") {
            indexValue = row[2];
        }

        if (valueColumn == "product") {
            valueValue = row[0];
        } else if (valueColumn == "store") {
            valueValue = row[1];
        } else if (valueColumn == "price") {
            valueValue = row[2];
        }

        pivotedData[indexValue][pivotValue] = valueValue;
    }

    vector<string> pivotValues;
    for (auto& row : data) {
        string pivotValue;
        if (pivotColumn == "product") {
            pivotValue = row[0];
        } else if (pivotColumn == "store") {
            pivotValue = row[1];
        } else if (pivotColumn == "price") {
            pivotValue = row[2];
        }
        bool found = false;
        for (const string& pv : pivotValues) {
            if (pv == pivotValue) {
                found = true;
                break;
            }
        }
        if (!found) {
            pivotValues.push_back(pivotValue);
        }
    }

    sort(pivotValues.begin(), pivotValues.end());

    vector<string> indexValues;
    for (auto& row : data) {
        string indexValue;
        if (indexColumn == "product") {
            indexValue = row[0];
        } else if (indexColumn == "store") {
            indexValue = row[1];
        } else if (indexColumn == "price") {
            indexValue = row[2];
        }
        bool found = false;
        for (const string& iv : indexValues) {
            if (iv == indexValue) {
                found = true;
                break;
            }
        }
        if (!found) {
            indexValues.push_back(indexValue);
        }
    }
    sort(indexValues.begin(), indexValues.end());

    vector<vector<string>> result;
    vector<string> header;
    header.push_back(indexColumn);
    for (const string& pv : pivotValues) {
        header.push_back(pv);
    }
    result.push_back(header);

    for (const string& indexValue : indexValues) {
        vector<string> row;
        row.push_back(indexValue);
        for (const string& pivotValue : pivotValues) {
            if (pivotedData[indexValue].count(pivotValue)) {
                row.push_back(pivotedData[indexValue][pivotValue]);
            } else {
                row.push_back("0");
            }
        }
        result.push_back(row);
    }

    return result;
}