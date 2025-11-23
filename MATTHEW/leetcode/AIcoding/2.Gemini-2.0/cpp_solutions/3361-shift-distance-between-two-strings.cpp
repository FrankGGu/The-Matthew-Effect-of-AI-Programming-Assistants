#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int shiftedDiff(string s, string t) {
        if (s.length() != t.length()) {
            return -1;
        }
        if (s == t) {
            return 0;
        }

        for (int i = 1; i < s.length(); ++i) {
            string shifted_s = s.substr(i) + s.substr(0, i);
            if (shifted_s == t) {
                return i;
            }
        }

        return -1;
    }
};