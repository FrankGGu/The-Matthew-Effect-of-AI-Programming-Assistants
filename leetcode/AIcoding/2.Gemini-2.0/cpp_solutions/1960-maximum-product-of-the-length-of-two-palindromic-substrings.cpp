#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxProduct(string s) {
        int n = s.length();
        vector<int> left(n, 0);
        vector<int> right(n, 0);

        for (int i = 0; i < n; ++i) {
            for (int len = 1; i - len + 1 >= 0 && i + len - 1 < n; ++len) {
                if (s[i - len + 1] == s[i + len - 1]) {
                    left[i + len - 1] = max(left[i + len - 1], 2 * len - 1);
                } else {
                    break;
                }
            }
            for (int len = 1; i - len >= 0 && i + len - 1 < n; ++len) {
                if (s[i - len] == s[i + len - 1]) {
                    left[i + len - 1] = max(left[i + len - 1], 2 * len);
                } else {
                    break;
                }
            }
        }

        for (int i = n - 1; i >= 0; --i) {
            for (int len = 1; i - len + 1 >= 0 && i + len - 1 < n; ++len) {
                if (s[i - len + 1] == s[i + len - 1]) {
                    right[i - len + 1] = max(right[i - len + 1], 2 * len - 1);
                } else {
                    break;
                }
            }
            for (int len = 1; i - len >= 0 && i + len - 1 < n; ++len) {
                if (s[i - len] == s[i + len - 1]) {
                    right[i - len] = max(right[i - len], 2 * len);
                } else {
                    break;
                }
            }
        }

        for (int i = 1; i < n; ++i) {
            left[i] = max(left[i], left[i - 1]);
        }
        for (int i = n - 2; i >= 0; --i) {
            right[i] = max(right[i], right[i + 1]);
        }

        int ans = 0;
        for (int i = 0; i < n - 1; ++i) {
            ans = max(ans, left[i] * right[i + 1]);
        }

        return ans;
    }
};