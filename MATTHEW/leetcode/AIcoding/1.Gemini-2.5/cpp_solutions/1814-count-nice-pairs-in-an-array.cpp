#include <vector>
#include <string>
#include <algorithm>
#include <unordered_map>

class Solution {
public:
    int rev(int n) {
        int reversed_n = 0;
        while (n > 0) {
            reversed_n = reversed_n * 10 + (n % 10);
            n /= 10;
        }
        return reversed_n;
    }

    int countNicePairs(std::vector<int>& nums) {
        std::unordered_map<int, int> freq_map;
        long long nice_pairs_count = 0;
        const int MOD = 1e9 + 7;

        for (int num : nums) {
            int diff = num - rev(num);
            nice_pairs_count = (nice_pairs_count + freq_map[diff]) % MOD;
            freq_map[diff]++;
        }

        return static_cast<int>(nice_pairs_count);
    }
};