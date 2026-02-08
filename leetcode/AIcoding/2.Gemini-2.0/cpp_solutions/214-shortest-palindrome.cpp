#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string shortestPalindrome(string s) {
        string t = s + "#" + string(s.rbegin(), s.rend());
        vector<int> kmp(t.size(), 0);
        for (int i = 1; i < t.size(); ++i) {
            int j = kmp[i - 1];
            while (j > 0 && t[i] != t[j]) {
                j = kmp[j - 1];
            }
            if (t[i] == t[j]) {
                ++j;
            }
            kmp[i] = j;
        }
        return string(s.rbegin(), s.rend()).substr(0, s.size() - kmp.back()) + s;
    }
};