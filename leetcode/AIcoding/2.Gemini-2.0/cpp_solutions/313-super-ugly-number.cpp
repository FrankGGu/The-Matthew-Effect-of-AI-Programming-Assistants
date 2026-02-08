#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int nthSuperUglyNumber(int n, vector<int>& primes) {
        vector<long long> ugly(n);
        ugly[0] = 1;
        vector<int> pointers(primes.size(), 0);

        for (int i = 1; i < n; ++i) {
            long long min_ugly = -1;
            for (int j = 0; j < primes.size(); ++j) {
                long long current_ugly = (long long)primes[j] * ugly[pointers[j]];
                if (min_ugly == -1 || current_ugly < min_ugly) {
                    min_ugly = current_ugly;
                }
            }
            ugly[i] = min_ugly;

            for (int j = 0; j < primes.size(); ++j) {
                if ((long long)primes[j] * ugly[pointers[j]] == min_ugly) {
                    pointers[j]++;
                }
            }
        }

        return (int)ugly[n - 1];
    }
};