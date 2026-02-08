#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> groupStrings(vector<string>& strings) {
        unordered_map<string, vector<string>> groups;

        for (const string& s : strings) {
            string key = "";
            for (int i = 1; i < s.size(); ++i) {
                int diff = (s[i] - s[i-1] + 26) % 26;
                key += to_string(diff) + ",";
            }
            groups[key].push_back(s);
        }

        vector<vector<string>> result;
        for (auto& pair : groups) {
            result.push_back(pair.second);
        }

        return result;
    }
};