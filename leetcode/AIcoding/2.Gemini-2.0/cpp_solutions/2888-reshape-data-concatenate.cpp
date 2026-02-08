#include <vector>

using namespace std;

vector<vector<int>> concatenate(vector<vector<int>>& arr1, vector<vector<int>>& arr2) {
    vector<vector<int>> result;
    for (const auto& row : arr1) {
        result.push_back(row);
    }
    for (const auto& row : arr2) {
        result.push_back(row);
    }
    return result;
}