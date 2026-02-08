#include <vector>

class Solution {
public:
    int threeSumMulti(std::vector<int>& arr, int target) {
        long long count[101] = {0};
        for (int x : arr) {
            count[x]++;
        }

        long long ans = 0;
        long long MOD = 1e9 + 7;

        for (int i = 0; i <= 100; ++i) {
            if (count[i] == 0) continue;

            for (int j = i; j <= 100; ++j) {
                if (count[j] == 0) continue;

                int k = target - i - j;

                if (k < j || k > 100) {
                    continue;
                }
                if (count[k] == 0) {
                    continue;
                }

                if (i == j && j == k) {
                    ans = (ans + count[i] * (count[i] - 1) * (count[i] - 2) / 6) % MOD;
                } else if (i == j && j < k) {
                    ans = (ans + count[i] * (count[i] - 1) / 2 * count[k]) % MOD;
                } else if (i < j && j == k) {
                    ans = (ans + count[i] * count[j] * (count[j] - 1) / 2) % MOD;
                } else { // i < j < k
                    ans = (ans + count[i] * count[j] * count[k]) % MOD;
                }
            }
        }

        return static_cast<int>(ans);
    }
};