#include <vector>
#include <deque>

using namespace std;

class Solution {
public:
    long long totalStrength(vector<int>& strength) {
        int n = strength.size();
        const int MOD = 1e9 + 7;

        vector<long long> prefix(n + 1, 0);
        vector<long long> prefix_prefix(n + 2, 0);

        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = (prefix[i] + strength[i]) % MOD;
        }
        for (int i = 0; i <= n; ++i) {
            prefix_prefix[i + 1] = (prefix_prefix[i] + prefix[i]) % MOD;
        }

        vector<int> left(n, -1);
        vector<int> right(n, n);
        deque<int> dq;

        for (int i = 0; i < n; ++i) {
            while (!dq.empty() && strength[dq.back()] >= strength[i]) {
                dq.pop_back();
            }
            left[i] = dq.empty() ? -1 : dq.back();
            dq.push_back(i);
        }

        dq.clear();
        for (int i = n - 1; i >= 0; --i) {
            while (!dq.empty() && strength[dq.back()] > strength[i]) {
                dq.pop_back();
            }
            right[i] = dq.empty() ? n : dq.back();
            dq.push_back(i);
        }

        long long res = 0;
        for (int i = 0; i < n; ++i) {
            int l = left[i] + 1;
            int r = right[i] - 1;

            long long sum_right = (prefix_prefix[r + 2] - prefix_prefix[i + 1] + MOD) % MOD;
            sum_right = sum_right * (i - l + 1) % MOD;

            long long sum_left = (prefix_prefix[i + 1] - prefix_prefix[l] + MOD) % MOD;
            sum_left = sum_left * (r - i + 1) % MOD;

            long long total = (sum_right - sum_left + MOD) % MOD;
            res = (res + total * strength[i]) % MOD;
        }

        return res;
    }
};