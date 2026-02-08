#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    vector<int> waysToFillArray(vector<vector<int>>& queries) {
        const int MOD = 1e9 + 7;
        int max_k = 0;
        for (auto& q : queries) {
            max_k = max(max_k, q[1]);
        }

        vector<int> spf(max_k + 1);
        for (int i = 2; i <= max_k; ++i) {
            if (spf[i] == 0) {
                spf[i] = i;
                for (int j = i * i; j <= max_k; j += i) {
                    if (spf[j] == 0) spf[j] = i;
                }
            }
        }

        vector<vector<int>> comb(10050, vector<int>(15, 0));
        comb[0][0] = 1;
        for (int i = 1; i < 10050; ++i) {
            comb[i][0] = 1;
            for (int j = 1; j < 15; ++j) {
                comb[i][j] = (comb[i-1][j-1] + comb[i-1][j]) % MOD;
            }
        }

        vector<int> res;
        for (auto& q : queries) {
            int n = q[0], k = q[1];
            if (k == 1) {
                res.push_back(1);
                continue;
            }
            unordered_map<int, int> primes;
            while (k > 1) {
                primes[spf[k]]++;
                k /= spf[k];
            }
            long long ans = 1;
            for (auto& p : primes) {
                int cnt = p.second;
                ans = (ans * comb[n + cnt - 1][cnt]) % MOD;
            }
            res.push_back(ans);
        }
        return res;
    }
};