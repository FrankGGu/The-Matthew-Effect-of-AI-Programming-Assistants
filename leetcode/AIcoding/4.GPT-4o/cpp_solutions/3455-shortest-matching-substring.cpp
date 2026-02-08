#include <string>
#include <unordered_map>
#include <limits>

class Solution {
public:
    std::string minWindow(std::string s, std::string t) {
        if (t.empty() || s.empty()) return "";

        std::unordered_map<char, int> charCount;
        for (char c : t) charCount[c]++;

        int required = charCount.size();
        int l = 0, r = 0, formed = 0;
        std::unordered_map<char, int> windowCount;
        int minLength = std::numeric_limits<int>::max();
        int minLeft = 0;

        while (r < s.size()) {
            char c = s[r];
            windowCount[c]++;
            if (charCount.count(c) && windowCount[c] == charCount[c]) {
                formed++;
            }

            while (l <= r && formed == required) {
                if (r - l + 1 < minLength) {
                    minLength = r - l + 1;
                    minLeft = l;
                }
                windowCount[s[l]]--;
                if (charCount.count(s[l]) && windowCount[s[l]] < charCount[s[l]]) {
                    formed--;
                }
                l++;
            }
            r++;
        }

        return minLength == std::numeric_limits<int>::max() ? "" : s.substr(minLeft, minLength);
    }
};