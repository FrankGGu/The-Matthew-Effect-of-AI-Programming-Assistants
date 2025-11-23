#include <iostream>
#include <vector>
#include <map>
#include <string>

using namespace std;

class Solution {
public:
    static vector<vector<string>> createDataFrame(vector<string> names, vector<int> ages) {
        vector<vector<string>> result;
        for (int i = 0; i < names.size(); ++i) {
            vector<string> row;
            row.push_back(names[i]);
            row.push_back(to_string(ages[i]));
            result.push_back(row);
        }
        return result;
    }
};