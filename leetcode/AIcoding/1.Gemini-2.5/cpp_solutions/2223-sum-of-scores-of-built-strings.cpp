#include <string>
#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long sumScores(std::string s) {
        int n = s.length();
        if (n == 0) {
            return 0;
        }

        std::vector<int> z(n);
        z[0] = n;

        int L = 0, R = 0;

        for (int i = 1; i < n; ++i) {
            if (i <= R) {
                z[i] = std::min(R - i + 1, z[i - L]);
            }

            while (i + z[i] < n && s[z[i]] == s[i + z[i]]) {
                z[i]++;
            }

            if (i + z[i] - 1 > R) {
                L = i;
                R = i + z[i] - 1;
            }
        }

        long long total_score = 0;
        for (int score : z) {
            total_score += score;
        }

        return total_score;
    }
};