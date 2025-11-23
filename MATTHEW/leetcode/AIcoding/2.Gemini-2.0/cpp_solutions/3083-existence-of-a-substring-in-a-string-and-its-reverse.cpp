#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool exist(string text, string pattern) {
        if (text.empty() || pattern.empty()) {
            return false;
        }

        if (text.length() < pattern.length()) {
            return false;
        }

        string reversed_pattern = pattern;
        reverse(reversed_pattern.begin(), reversed_pattern.end());

        return text.find(pattern) != string::npos || text.find(reversed_pattern) != string::npos;
    }
};