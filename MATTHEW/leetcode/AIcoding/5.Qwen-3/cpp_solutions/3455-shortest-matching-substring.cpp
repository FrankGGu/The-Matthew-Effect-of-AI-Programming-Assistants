#include <iostream>
#include <vector>
#include <string>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string shortestSubstring(string s, string p) {
        int n = s.size();
        int m = p.size();
        vector<int> count(256, 0);
        int required = m;
        for (char c : p) {
            if (count[c] == 0) required--;
            count[c]++;
        }

        int left = 0, minLen = INT_MAX, found = 0;
        string result = "";
        for (int right = 0; right < n; right++) {
            char c = s[right];
            count[c]--;
            if (count[c] == 0) found++;

            while (found == required) {
                if (right - left + 1 < minLen) {
                    minLen = right - left + 1;
                    result = s.substr(left, minLen);
                }

                count[s[left]]++;
                if (count[s[left]] == 1) found--;
                left++;
            }
        }
        return result;
    }
};