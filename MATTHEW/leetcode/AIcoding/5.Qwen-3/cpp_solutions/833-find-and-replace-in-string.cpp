#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string findReplaceString(string s, vector<int>& indices, vector<string>& sources, vector<string>& targets) {
        int n = indices.size();
        vector<pair<int, int>> indexMap(n);
        for (int i = 0; i < n; ++i) {
            indexMap[i] = {indices[i], i};
        }
        sort(indexMap.begin(), indexMap.end());
        for (int i = n - 1; i >= 0; --i) {
            int idx = indexMap[i].first;
            int originalIndex = indexMap[i].second;
            string source = sources[originalIndex];
            string target = targets[originalIndex];
            if (s.substr(idx, source.length()) == source) {
                s.replace(idx, source.length(), target);
            }
        }
        return s;
    }
};