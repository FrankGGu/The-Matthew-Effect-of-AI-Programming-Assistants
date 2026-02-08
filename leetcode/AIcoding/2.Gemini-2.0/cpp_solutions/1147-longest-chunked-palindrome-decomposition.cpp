#include <string>

using namespace std;

class Solution {
public:
    int longestDecomposition(string text) {
        int n = text.length();
        int ans = 0;
        int l = 0, r = n - 1;
        while (l <= r) {
            int len = 1;
            while (l + len - 1 < r - len + 1) {
                if (text.substr(l, len) == text.substr(r - len + 1, len)) {
                    ans += 2;
                    l += len;
                    r -= len;
                    break;
                }
                len++;
            }
            if (l + len - 1 >= r - len + 1) {
                ans++;
                break;
            }
        }
        return ans;
    }
};