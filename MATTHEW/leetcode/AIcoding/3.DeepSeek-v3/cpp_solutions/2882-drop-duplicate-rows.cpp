#include <vector>
#include <unordered_set>
#include <string>

using namespace std;

class Solution {
public:
    vector<vector<string>> dropDuplicateRows(vector<vector<string>>& input) {
        unordered_set<string> seen;
        vector<vector<string>> result;

        for (const auto& row : input) {
            string key;
            for (const auto& cell : row) {
                key += cell + ",";
            }
            if (seen.find(key) == seen.end()) {
                seen.insert(key);
                result.push_back(row);
            }
        }

        return result;
    }
};