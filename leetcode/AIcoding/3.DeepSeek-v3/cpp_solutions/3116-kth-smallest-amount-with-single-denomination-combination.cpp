#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    long long findKthSmallest(vector<int>& coins, int k) {
        long long left = 1, right = 1e18;
        while (left < right) {
            long long mid = left + (right - left) / 2;
            if (count(coins, mid) >= k) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

private:
    long long count(vector<int>& coins, long long target) {
        int n = coins.size();
        long long res = 0;
        for (int mask = 1; mask < (1 << n); ++mask) {
            long long lcm = 1;
            int bits = 0;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    ++bits;
                    lcm = lcm * coins[i] / __gcd(lcm, (long long)coins[i]);
                    if (lcm > target) break;
                }
            }
            if (bits % 2 == 1) {
                res += target / lcm;
            } else {
                res -= target / lcm;
            }
        }
        return res;
    }
};