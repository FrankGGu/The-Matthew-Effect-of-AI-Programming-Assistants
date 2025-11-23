#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<string> longestCommonSuffixQueries(vector<string>& s, vector<vector<int>>& queries) {
        int n = s.size();
        vector<string> result;
        unordered_map<string, int> suffixMap;

        for (int i = 0; i < n; ++i) {
            string current = s[i];
            for (int j = 0; j < current.length(); ++j) {
                string suffix = current.substr(j);
                if (suffixMap.find(suffix) == suffixMap.end()) {
                    suffixMap[suffix] = 1;
                } else {
                    suffixMap[suffix]++;
                }
            }
        }

        for (auto& query : queries) {
            int l = query[0];
            int r = query[1];
            string commonSuffix = "";
            for (int i = 0; i < s[l].length(); ++i) {
                string suffix = s[l].substr(i);
                if (suffixMap[suffix] >= (r - l + 1)) {
                    commonSuffix = suffix;
                } else {
                    break;
                }
            }
            result.push_back(commonSuffix);
        }

        return result;
    }
};