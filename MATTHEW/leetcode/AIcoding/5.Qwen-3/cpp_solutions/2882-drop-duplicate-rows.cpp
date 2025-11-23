#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<vector<int>> dropDuplicateRows(vector<vector<int>>& m) {
        unordered_set<string> seen;
        vector<vector<int>> result;
        for (const auto& row : m) {
            string key;
            for (int num : row) {
                key += to_string(num) + ",";
            }
            if (seen.find(key) == seen.end()) {
                seen.insert(key);
                result.push_back(row);
            }
        }
        return result;
    }
};