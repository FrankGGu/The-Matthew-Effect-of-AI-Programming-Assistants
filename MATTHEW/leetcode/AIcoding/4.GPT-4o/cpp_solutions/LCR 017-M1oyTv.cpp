#include <string>
#include <unordered_map>
#include <limits>

using namespace std;

class Solution {
public:
    string minWindow(string s, string t) {
        unordered_map<char, int> dict;
        for (char c : t) dict[c]++;

        int required = dict.size();
        int l = 0, r = 0, formed = 0;

        unordered_map<char, int> windowCounts;
        int minLen = numeric_limits<int>::max(), minLeft = 0;

        while (r < s.size()) {
            char c = s[r];
            windowCounts[c]++;
            if (dict.count(c) && windowCounts[c] == dict[c]) {
                formed++;
            }

            while (l <= r && formed == required) {
                c = s[l];
                if (r - l + 1 < minLen) {
                    minLen = r - l + 1;
                    minLeft = l;
                }
                windowCounts[c]--;
                if (dict.count(c) && windowCounts[c] < dict[c]) {
                    formed--;
                }
                l++;
            }
            r++;
        }

        return minLen == numeric_limits<int>::max() ? "" : s.substr(minLeft, minLen);
    }
};