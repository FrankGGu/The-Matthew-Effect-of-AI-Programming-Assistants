#include <vector>
#include <string>
#include <numeric>
#include <algorithm>

class Solution {
public:
    char findKthCharacter(int n, std::vector<std::string>& t, long long k) {
        std::vector<long long> len(n + 1);
        len[0] = 1;
        std::vector<int> t_len(n);
        for (int i = 0; i < n; ++i) {
            t_len[i] = t[i].length();
        }

        for (int i = 1; i <= n; ++i) {
            len[i] = len[i - 1] + t_len[i - 1] * 2LL + 1;
        }

        k--; 
        if (len[n] > 0) {
            k %= len[n];
        }

        for (int i = n; i > 0; --i) {
            long long prev_len = len[i - 1];
            int current_t_len = t_len[i - 1];

            if (k < prev_len) {
                continue;
            }
            k -= prev_len;

            if (k < current_t_len) {
                return t[i - 1][k];
            }
            k -= current_t_len;

            if (k < current_t_len) {
                return t[i - 1][current_t_len - 1 - k];
            }

            return 'a';
        }

        return 'a';
    }
};