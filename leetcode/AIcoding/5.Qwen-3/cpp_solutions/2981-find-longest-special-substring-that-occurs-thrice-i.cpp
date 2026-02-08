#include <iostream>
#include <vector>
#include <unordered_map>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumLength(string s) {
        unordered_map<string, int> count;
        int n = s.length();
        for (int i = 0; i < n; ++i) {
            char c = s[i];
            int len = 1;
            for (int j = i + 1; j < n && s[j] == c; ++j) {
                len++;
            }
            for (int l = 1; l <= len; ++l) {
                string sub = string(l, c);
                count[sub]++;
            }
        }

        int maxLen = -1;
        for (auto& [sub, cnt] : count) {
            if (cnt >= 3) {
                maxLen = max(maxLen, (int)sub.length());
            }
        }
        return maxLen;
    }
};