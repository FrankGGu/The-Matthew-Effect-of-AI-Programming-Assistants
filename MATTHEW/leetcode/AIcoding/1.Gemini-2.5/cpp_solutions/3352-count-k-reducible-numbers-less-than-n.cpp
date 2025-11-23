#include <string>
#include <vector>
#include <cstring>

using namespace std;

class Solution {
public:
    long long countKReducible(long long n, int k) {
        if (n <= 1) {
            return 0;
        }
        s = to_string(n - 1);
        this->k = k;
        len = s.length();
        memset(memo, -1, sizeof(memo));
        return dp(0, 0, true) - 1;
    }

private:
    string s;
    int k;
    int len;
    long long memo[20][101][2];

    long long dp(int index, int sum_mod, bool is_tight) {
        if (index == len) {
            return sum_mod == 0;
        }
        if (memo[index][sum_mod][is_tight] != -1) {
            return memo[index][sum_mod][is_tight];
        }

        long long count = 0;
        int upper_bound = is_tight ? (s[index] - '0') : 9;

        for (int digit = 0; digit <= upper_bound; ++digit) {
            bool new_tight = is_tight && (digit == upper_bound);
            count += dp(index + 1, (sum_mod + digit) % k, new_tight);
        }

        return memo[index][sum_mod][is_tight] = count;
    }
};