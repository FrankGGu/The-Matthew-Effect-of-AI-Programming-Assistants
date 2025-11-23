#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int minimumScore(std::string s, std::string t) {
        int n = s.length();
        int m = t.length();

        std::vector<int> prefix(n + 1, 0);
        int k = 0;
        for (int i = 0; i < n; ++i) {
            if (k < m && s[i] == t[k]) {
                k++;
            }
            prefix[i + 1] = k;
        }

        std::vector<int> suffix(n + 1, 0);
        k = m - 1;
        for (int i = n - 1; i >= 0; --i) {
            if (k >= 0 && s[i] == t[k]) {
                k--;
            }
            suffix[i] = m - 1 - k;
        }

        int min_len = n;
        int j = 0;
        for (int i = 0; i <= n; ++i) {
            int rem_len = m - prefix[i];

            while (j <= n && (j < i || suffix[j] < rem_len)) {
                j++;
            }

            if (j <= n) {
                min_len = std::min(min_len, j - i);
            } else {
                break;
            }
        }

        return min_len;
    }
};