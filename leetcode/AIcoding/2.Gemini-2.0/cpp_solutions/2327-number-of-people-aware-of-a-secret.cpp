#include <vector>

using namespace std;

class Solution {
public:
    int peopleAwareOfSecret(int n, int delay, int forget) {
        long long mod = 1e9 + 7;
        vector<long long> aware(n + 1, 0);
        aware[1] = 1;
        long long sharing = 0;

        for (int i = 1; i <= n; ++i) {
            long long new_sharing = aware[i];
            for (int j = i + delay; j <= min(n, i + forget - 1); ++j) {
                aware[j] = (aware[j] + new_sharing) % mod;
            }
            sharing = (sharing + new_sharing) % mod;
            if (i >= forget) {
                sharing = (sharing - aware[i - forget + 1] + mod) % mod;
            }
        }

        return sharing;
    }
};