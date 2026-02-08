#include <vector>
#include <algorithm> // Required for std::sort and std::max

class Solution {
public:
    long long power(long long base, long long exp) {
        long long res = 1;
        long long MOD = 1e9 + 7;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    int countWays(std::vector<std::vector<int>>& ranges) {
        if (ranges.empty()) {
            return 1;
        }

        std::sort(ranges.begin(), ranges.end());

        int count = 1; 
        int current_end = ranges[0][1];

        for (size_t i = 1; i < ranges.size(); ++i) {
            if (ranges[i][0] <= current_end) {
                current_end = std::max(current_end, ranges[i][1]);
            } else {
                count++;
                current_end = ranges[i][1];
            }
        }

        return power(2, count);
    }
};