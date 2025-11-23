#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int totalCharacters(vector<string>& words) {
        int n = words.size();
        if (n == 0) return 0;

        string s = words[0];
        for (int i = 1; i < n; ++i) {
            string t = words[i];
            int len_s = s.length();
            int len_t = t.length();
            int len = min(len_s, len_t);

            string common_prefix = "";
            for (int j = 0; j < len; ++j) {
                if (s[j] == t[j]) {
                    common_prefix += s[j];
                } else {
                    break;
                }
            }

            s = common_prefix;
        }

        return s.length();
    }
};