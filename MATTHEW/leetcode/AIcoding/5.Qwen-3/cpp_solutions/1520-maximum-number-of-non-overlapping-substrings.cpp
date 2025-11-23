#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> maxNumOfSubstrings(string s) {
        unordered_map<char, pair<int, int>> charRange;
        for (int i = 0; i < s.size(); ++i) {
            if (charRange.find(s[i]) == charRange.end()) {
                charRange[s[i]] = {i, i};
            }
            charRange[s[i]].second = i;
        }

        vector<pair<int, int>> ranges;
        for (auto& [c, p] : charRange) {
            ranges.push_back(p);
        }

        sort(ranges.begin(), ranges.end());

        vector<string> result;
        int lastEnd = -1;

        for (const auto& [start, end] : ranges) {
            if (start > lastEnd) {
                result.push_back(s.substr(start, end - start + 1));
                lastEnd = end;
            }
        }

        return result;
    }
};