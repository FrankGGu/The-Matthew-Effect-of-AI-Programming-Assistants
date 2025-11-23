#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minBeautifulPartitions(string s, int k) {
        int n = s.size();
        vector<bool> is_prime(101, true);
        is_prime[0] = is_prime[1] = false;
        for (int i = 2; i * i <= 100; ++i) {
            if (is_prime[i]) {
                for (int j = i * i; j <= 100; j += i) {
                    is_prime[j] = false;
                }
            }
        }

        if (!is_prime[s[0] - '0']) return -1;

        vector<int> dp(n + 1, n + 1);
        dp[0] = 0;

        for (int i = 0; i < n; ++i) {
            if (dp[i] == n + 1) continue;
            for (int j = i + k; j <= n; ++j) {
                string sub = s.substr(i, j - i);
                if (sub[0] == '0' || sub.size() > 7) continue;
                int num = stoi(sub);
                if (is_prime[sub[0] - '0'] && num >= pow(5, (int)log(num) / log(5)) && num < pow(5, (int)log(num) / log(5) + 1)) {
                    dp[j] = min(dp[j], dp[i] + 1);
                }
            }
        }

        return (dp[n] == n + 1) ? -1 : dp[n];
    }
};