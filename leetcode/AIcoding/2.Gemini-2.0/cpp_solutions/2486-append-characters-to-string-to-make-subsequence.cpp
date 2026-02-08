#include <string>

using namespace std;

class Solution {
public:
    int appendCharacters(string s, string t) {
        int s_idx = 0;
        int t_idx = 0;

        while (s_idx < s.length() && t_idx < t.length()) {
            if (s[s_idx] == t[t_idx]) {
                t_idx++;
            }
            s_idx++;
        }

        return t.length() - t_idx;
    }
};