#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minLength(string s) {
        while (true) {
            bool changed = false;
            for (int i = 0; i < s.length() - 1; ++i) {
                if ((s[i] == 'A' && s[i + 1] == 'B') || (s[i] == 'C' && s[i + 1] == 'D')) {
                    s.erase(i, 2);
                    changed = true;
                    break;
                }
            }
            if (!changed) break;
        }
        return s.length();
    }
};