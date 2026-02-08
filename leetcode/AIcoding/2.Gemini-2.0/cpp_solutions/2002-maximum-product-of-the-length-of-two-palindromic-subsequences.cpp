#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxProduct(string s) {
        int n = s.length();
        int ans = 0;

        function<bool(string)> isPalindrome = [&](string str) {
            string rev = str;
            reverse(rev.begin(), rev.end());
            return str == rev;
        };

        function<void(int, string, string)> solve = [&](int idx, string s1, string s2) {
            if (idx == n) {
                if (isPalindrome(s1) && isPalindrome(s2)) {
                    ans = max(ans, (int)s1.length() * (int)s2.length());
                }
                return;
            }

            solve(idx + 1, s1 + s[idx], s2);
            solve(idx + 1, s1, s2 + s[idx]);
            solve(idx + 1, s1, s2);
        };

        solve(0, "", "");

        return ans;
    }
};