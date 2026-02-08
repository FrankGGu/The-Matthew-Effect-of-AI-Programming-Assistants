#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<vector<int>> changeDataType(vector<vector<int>>& data) {
        for (auto& row : data) {
            for (int& val : row) {
                val = static_cast<int>(val);
            }
        }
        return data;
    }
};