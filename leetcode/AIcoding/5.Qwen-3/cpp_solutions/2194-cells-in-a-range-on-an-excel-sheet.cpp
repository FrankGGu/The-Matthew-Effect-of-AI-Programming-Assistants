#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> cellsInRange(string s) {
        vector<string> result;
        char start_col = s[0];
        char end_col = s[3];
        int start_row = stoi(s.substr(1, 1));
        int end_row = stoi(s.substr(4, 1));

        for (char col = start_col; col <= end_col; ++col) {
            for (int row = start_row; row <= end_row; ++row) {
                string cell(1, col);
                cell += to_string(row);
                result.push_back(cell);
            }
        }

        return result;
    }
};