#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<vector<string>> modifyColumns(vector<vector<string>> employees) {
        for (int i = 0; i < employees.size(); ++i) {
            string temp = employees[i][0];
            employees[i][0] = employees[i][1];
            employees[i][1] = temp;
        }
        return employees;
    }
};