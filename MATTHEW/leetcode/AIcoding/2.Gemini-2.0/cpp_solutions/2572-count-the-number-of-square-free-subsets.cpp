#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int countSquareFreeSubsets(vector<int>& nums) {
        vector<int> primes = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};
        vector<int> mask(31, 0);
        vector<int> good;
        for (int i = 1; i <= 30; ++i) {
            bool square_free = true;
            int m = 0;
            int num = i;
            for (int j = 0; j < primes.size(); ++j) {
                int count = 0;
                while (num % primes[j] == 0) {
                    num /= primes[j];
                    count++;
                }
                if (count > 1) {
                    square_free = false;
                    break;
                }
                if (count == 1) {
                    m |= (1 << j);
                }
            }
            if (square_free) {
                mask[i] = m;
                good.push_back(i);
            }
        }

        int n = nums.size();
        int mod = 1e9 + 7;
        vector<int> dp(1 << 10, 0);
        dp[0] = 1;

        int ones = 0;
        for (int num : nums) {
            if (mask[num] == 0) {
                ones++;
            } else {
                for (int i = (1 << 10) - 1; i >= 0; --i) {
                    if ((i & mask[num]) == 0) {
                        dp[i | mask[num]] = (dp[i | mask[num]] + dp[i]) % mod;
                    }
                }
            }
        }

        int ans = 0;
        for (int i = 1; i < (1 << 10); ++i) {
            ans = (ans + dp[i]) % mod;
        }

        long long power_of_two = 1;
        for (int i = 0; i < ones; ++i) {
            power_of_two = (power_of_two * 2) % mod;
        }

        ans = (long long)ans * power_of_two % mod;

        return ans;
    }
};