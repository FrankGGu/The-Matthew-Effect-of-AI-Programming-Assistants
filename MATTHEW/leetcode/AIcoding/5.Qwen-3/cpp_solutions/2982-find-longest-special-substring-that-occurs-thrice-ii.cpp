#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumLength(string s) {
        unordered_map<string, int> count;
        int n = s.length();
        for (int i = 0; i < n; ++i) {
            char c = s[i];
            int j = i;
            while (j < n && s[j] == c) ++j;
            int len = j - i;
            for (int k = 1; k <= len; ++k) {
                string sub = string(k, c);
                count[sub]++;
            }
            i = j - 1;
        }

        int maxLen = -1;
        for (const auto& [sub, cnt] : count) {
            if (cnt >= 3) {
                maxLen = max(maxLen, (int)sub.length());
            }
        }
        return maxLen;
    }
};