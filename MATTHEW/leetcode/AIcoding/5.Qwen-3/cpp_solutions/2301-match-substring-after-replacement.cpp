#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool matchReplacement(string s, string t, string charMatchMap) {
        int n = s.size();
        int m = t.size();
        if (n != m) return false;
        unordered_map<char, vector<char>> map;
        for (int i = 0; i < charMatchMap.length(); i += 2) {
            char c = charMatchMap[i];
            char d = charMatchMap[i + 1];
            map[c].push_back(d);
        }
        for (int i = 0; i < n; ++i) {
            char sc = s[i];
            char tc = t[i];
            if (sc == tc) continue;
            bool found = false;
            for (char c : map[sc]) {
                if (c == tc) {
                    found = true;
                    break;
                }
            }
            if (!found) return false;
        }
        return true;
    }
};