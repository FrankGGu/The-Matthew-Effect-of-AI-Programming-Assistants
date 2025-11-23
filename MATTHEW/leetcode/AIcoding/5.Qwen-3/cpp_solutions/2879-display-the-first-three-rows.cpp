#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> displayFirstThreeRows(vector<vector<int>>& table) {
        vector<vector<int>> result;
        for (int i = 0; i < 3 && i < table.size(); ++i) {
            result.push_back(table[i]);
        }
        return result;
    }
};