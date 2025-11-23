#include <string>
#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<int> z_function(const std::string& s) {
        int n = s.length();
        std::vector<int> z(n);
        if (n == 0) return z;
        z[0] = n;
        int l = 0, r = 0;
        for (int i = 1; i < n; ++i) {
            if (i <= r) {
                z[i] = std::min(r - i + 1, z[i - l]);
            }
            while (i + z[i] < n && s[z[i]] == s[i + z[i]]) {
                ++z[i];
            }
            if (i + z[i] - 1 > r) {
                l = i;
                r = i + z[i] - 1;
            }
        }
        return z;
    }

    int minimumTimeToRevert(std::string word, int k) {
        int n = word.length();
        std::vector<int> z = z_function(word);

        for (int t = 1; ; ++t) {
            int offset = t * k;
            if (offset >= n) {
                return t;
            }
            // Check if word.substr(offset) matches word.substr(0, n - offset)
            // This is true if Z[offset] is at least n - offset
            if (z[offset] >= n - offset) {
                return t;
            }
        }
    }
};