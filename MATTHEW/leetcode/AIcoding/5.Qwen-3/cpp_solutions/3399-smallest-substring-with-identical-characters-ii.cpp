#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string smallestSubstringWithIdenticalCharacters(string s) {
        int n = s.size();
        unordered_map<char, vector<int>> pos;
        for (int i = 0; i < n; ++i) {
            pos[s[i]].push_back(i);
        }

        string result = "";
        int minLen = INT_MAX;

        for (auto& [ch, indices] : pos) {
            if (indices.size() < 2) continue;
            for (int i = 0; i < indices.size() - 1; ++i) {
                int start = indices[i];
                int end = indices[i + 1];
                int len = end - start + 1;
                if (len < minLen) {
                    minLen = len;
                    result = s.substr(start, len);
                }
            }
        }

        return result;
    }
};