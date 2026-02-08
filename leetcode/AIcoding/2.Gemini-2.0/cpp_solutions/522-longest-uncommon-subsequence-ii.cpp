#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool isSubsequence(const string& s, const string& t) {
        int i = 0, j = 0;
        while (i < s.length() && j < t.length()) {
            if (s[i] == t[j]) {
                i++;
            }
            j++;
        }
        return i == s.length();
    }

    int findLUSlength(vector<string>& strs) {
        int ans = -1;
        for (int i = 0; i < strs.size(); ++i) {
            bool unique = true;
            for (int j = 0; j < strs.size(); ++j) {
                if (i != j && isSubsequence(strs[i], strs[j])) {
                    unique = false;
                    break;
                }
            }
            if (unique) {
                ans = max(ans, (int)strs[i].length());
            }
        }
        return ans;
    }
};