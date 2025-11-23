#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string shortestSuperstring(string a, string b, string c) {
        string s[6];
        s[0] = solve(a, b, c);
        s[1] = solve(a, c, b);
        s[2] = solve(b, a, c);
        s[3] = solve(b, c, a);
        s[4] = solve(c, a, b);
        s[5] = solve(c, b, a);

        string ans = s[0];
        for (int i = 1; i < 6; ++i) {
            if (s[i].size() < ans.size()) {
                ans = s[i];
            }
        }
        return ans;
    }

private:
    string solve(string a, string b, string c) {
        string ab = merge(a, b);
        string abc = merge(ab, c);
        return abc;
    }

    string merge(string a, string b) {
        int n = a.size(), m = b.size();
        for (int i = min(n, m); i > 0; --i) {
            if (a.substr(n - i) == b.substr(0, i)) {
                return a + b.substr(i);
            }
        }
        return a + b;
    }
};