#include <vector>
#include <string>
using namespace std;

class Solution {
public:
    vector<vector<int>> concatenateTables(vector<vector<int>>& df1, vector<vector<int>>& df2) {
        vector<vector<int>> result = df1;
        result.insert(result.end(), df2.begin(), df2.end());
        return result;
    }
};