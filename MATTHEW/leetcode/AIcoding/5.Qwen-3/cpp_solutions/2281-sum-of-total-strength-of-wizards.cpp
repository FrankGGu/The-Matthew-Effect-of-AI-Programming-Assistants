#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    int totalStrength(vector<int>& strength) {
        int MOD = 1e9 + 7;
        int n = strength.size();

        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = (prefix[i] + strength[i]) % MOD;
        }

        vector<long long> prefix2(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix2[i + 1] = (prefix2[i] + prefix[i]) % MOD;
        }

        vector<int> left(n, -1);
        stack<int> s;
        for (int i = 0; i < n; ++i) {
            while (!s.empty() && strength[s.top()] >= strength[i]) {
                s.pop();
            }
            if (!s.empty()) {
                left[i] = s.top();
            }
            s.push(i);
        }

        vector<int> right(n, n);
        s = stack<int>();
        for (int i = n - 1; i >= 0; --i) {
            while (!s.empty() && strength[s.top()] > strength[i]) {
                s.pop();
            }
            if (!s.empty()) {
                right[i] = s.top();
            }
            s.push(i);
        }

        long long result = 0;
        for (int i = 0; i < n; ++i) {
            int l = left[i];
            int r = right[i];
            long long cnt = (long long)(i - l) * (r - i) % MOD;
            long long sum = (prefix[r] - prefix[i + 1]) % MOD;
            long long sum2 = (prefix2[r] - prefix2[i + 1]) % MOD;
            long long sub = (sum2 - (long long)(i + 1 - l) * sum) % MOD;
            result = (result + (long long)strength[i] * sub % MOD * cnt % MOD) % MOD;
        }

        return result;
    }
};