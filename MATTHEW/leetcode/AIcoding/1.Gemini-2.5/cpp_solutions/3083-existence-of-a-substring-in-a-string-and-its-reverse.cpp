#include <string>
#include <vector>
#include <algorithm>
#include <set>

class Solution {
public:
    bool isSubstringPresent(std::string s) {
        int n = s.length();
        if (n < 2) {
            return false;
        }

        std::set<std::string> substrings_in_s;

        for (int i = 0; i <= n - 2; ++i) {
            substrings_in_s.insert(s.substr(i, 2));
        }

        for (int i = 0; i <= n - 2; ++i) {
            std::string current_substring = s.substr(i, 2);
            std::string reversed_current_substring = current_substring;
            std::reverse(reversed_current_substring.begin(), reversed_current_substring.end());

            if (substrings_in_s.count(reversed_current_substring)) {
                return true;
            }
        }

        return false;
    }
};