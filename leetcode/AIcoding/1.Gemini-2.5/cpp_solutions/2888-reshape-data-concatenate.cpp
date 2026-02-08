#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> concatenate(vector<vector<int>>& arr1, vector<vector<int>>& arr2) {
        vector<vector<int>> result = arr1;
        result.insert(result.end(), arr2.begin(), arr2.end());
        return result;
    }
};