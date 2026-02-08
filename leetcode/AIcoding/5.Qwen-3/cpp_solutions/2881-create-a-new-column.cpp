#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<vector<int>> createNewColumn(vector<vector<int>>& employees, int newColumnValue) {
        for (auto& row : employees) {
            row.push_back(newColumnValue);
        }
        return employees;
    }
};