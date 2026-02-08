#include <vector>
#include <string>
#include <unordered_map>
#include <iostream>

using namespace std;

class DataFrame {
public:
    DataFrame(vector<string> columns, vector<vector<string>> data) : columns(move(columns)), data(move(data)) {}

    void print() {
        for (const auto& col : columns) {
            cout << col << " ";
        }
        cout << endl;
        for (const auto& row : data) {
            for (const auto& value : row) {
                cout << value << " ";
            }
            cout << endl;
        }
    }

private:
    vector<string> columns;
    vector<vector<string>> data;
};

class Solution {
public:
    DataFrame createDataFrame(vector<string> columns, vector<vector<string>> data) {
        return DataFrame(columns, data);
    }
};