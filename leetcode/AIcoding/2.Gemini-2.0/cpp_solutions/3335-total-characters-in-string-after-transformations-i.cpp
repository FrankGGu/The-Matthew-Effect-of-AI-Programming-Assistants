#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int solve(string s) {
        while (true) {
            bool changed = false;
            string new_s = "";
            for (int i = 0; i < s.length(); ++i) {
                if (i + 1 < s.length() && ((s[i] == 'A' && s[i + 1] == 'B') || (s[i] == 'C' && s[i + 1] == 'D'))) {
                    i++;
                    changed = true;
                } else {
                    new_s += s[i];
                }
            }
            s = new_s;
            if (!changed) {
                break;
            }
        }
        return s.length();
    }
};