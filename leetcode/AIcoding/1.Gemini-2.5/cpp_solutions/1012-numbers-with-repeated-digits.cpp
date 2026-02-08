#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    long long permutations(int n, int k) {
        if (k < 0 || k > n) {
            return 0;
        }
        long long res = 1;
        for (int i = 0; i < k; ++i) {
            res *= (n - i);
        }
        return res;
    }

    int numDupDigitsAtMostN(int n) {
        std::string s = std::to_string(n);
        int len = s.length();
        std::vector<int> digits;
        for (char c : s) {
            digits.push_back(c - '0');
        }

        long long count_distinct_less_than_N = 0;

        for (int k = 1; k < len; ++k) {
            count_distinct_less_than_N += 9 * permutations(9, k - 1);
        }

        long long count_distinct_same_length_le_N = 0;
        int seen_digits_mask = 0;

        for (int i = 0; i < len; ++i) {
            int current_digit = digits[i];

            for (int j = (i == 0 ? 1 : 0); j < current_digit; ++j) {
                if (!((seen_digits_mask >> j) & 1)) {
                    count_distinct_same_length_le_N += permutations(10 - (i + 1), len - 1 - i);
                }
            }

            if (((seen_digits_mask >> current_digit) & 1)) {
                break;
            }

            seen_digits_mask |= (1 << current_digit);

            if (i == len - 1) {
                count_distinct_same_length_le_N += 1;
            }
        }

        long long total_distinct_numbers = count_distinct_less_than_N + count_distinct_same_length_le_N;
        return n - total_distinct_numbers;
    }
};