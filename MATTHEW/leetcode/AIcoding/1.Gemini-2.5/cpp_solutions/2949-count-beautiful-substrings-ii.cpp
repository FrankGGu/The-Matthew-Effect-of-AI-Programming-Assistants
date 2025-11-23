#include <string>
#include <vector>
#include <map>
#include <cmath> // For std::pow and std::ceil, though custom integer power is used

bool is_vowel(char ch) {
    return ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u';
}

long long get_min_L_factor(int k) {
    long long min_L_factor = 1;
    int temp_k = k;

    for (int p = 2; (long long)p * p <= temp_k; ++p) {
        if (temp_k % p == 0) {
            int count = 0;
            while (temp_k % p == 0) {
                temp_k /= p;
                count++;
            }
            int required_power = (count + 1) / 2; // Equivalent to ceil(count / 2.0)
            for (int i = 0; i < required_power; ++i) {
                min_L_factor *= p;
            }
        }
    }
    if (temp_k > 1) { // Remaining temp_k is a prime factor
        min_L_factor *= temp_k;
    }
    return min_L_factor;
}

class Solution {
public:
    long long beautifulSubstrings(std::string s, int k) {
        int n = s.length();

        long long min_L_factor = get_min_L_factor(k);
        long long MOD_VAL = 2 * min_L_factor;

        long long beautiful_substrings_count = 0;

        std::map<std::pair<int, int>, int> freq;

        freq[{0, 0}] = 1;

        int current_diff = 0;

        for (int j = 0; j < n; ++j) {
            if (is_vowel(s[j])) {
                current_diff++;
            } else {
                current_diff--;
            }

            int current_prefix_len_mod = (j + 1) % MOD_VAL;

            beautiful_substrings_count += freq[{current_diff, current_prefix_len_mod}];

            freq[{current_diff, current_prefix_len_mod}]++;
        }

        return beautiful_substrings_count;
    }
};