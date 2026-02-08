#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxProfit(vector<int>& inventory, int orders) {
        long long l = 1, r = *max_element(inventory.begin(), inventory.end());
        long long ans = 0;
        int mod = 1e9 + 7;

        while (l <= r) {
            long long mid = l + (r - l) / 2;
            long long count = 0;
            for (int ball : inventory) {
                count += max(0LL, (long long)ball - mid + 1);
            }

            if (count >= orders) {
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }

        for (int ball : inventory) {
            if (ball > r) {
                long long num = ball - r;
                orders -= num;
                ans = (ans + ((long long)ball + r + 1) * num / 2) % mod;
            }
        }

        ans = (ans + (long long)orders * r) % mod;

        return (int)ans;
    }
};