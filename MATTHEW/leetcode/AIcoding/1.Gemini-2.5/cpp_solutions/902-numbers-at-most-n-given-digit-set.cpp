#include <string>
#include <vector>
#include <algorithm>
#include <cmath>

long long integer_pow(int base, int exp) {
    long long res = 1;
    for (int i = 0; i < exp; ++i) {
        res *= base;
    }
    return res;
}

class Solution {
public:
    int atMostN_givenDigitSet(std::vector<std::string>& digits, int n) {
        std::string n_str = std::to_string(n);
        int L = n_str.length();
        int m = digits.size();
        long long ans = 0;

        // Part 1: Count numbers with fewer digits than n_str
        // For each length k from 1 to L-1, there are m^k such numbers.
        for (int i = 1; i < L; ++i) {
            ans += integer_pow(m, i);
        }

        // Part 2: Count numbers with the same number of digits as n_str
        bool tight = true; // Indicates if the current prefix matches n_str's prefix
        for (int i = 0; i < L; ++i) {
            char char_N_i = n_str[i];
            bool found_digit_equal_to_N_i = false;

            for (const std::string& d_str : digits) {
                char char_d = d_str[0];

                if (tight) {
                    if (char_d < char_N_i) {
                        // If current digit `d` is smaller than N's digit at this position,
                        // we can place `d` here. The remaining L - 1 - i positions can be filled
                        // with any of the `m` available digits.
                        ans += integer_pow(m, L - 1 - i);
                    } else if (char_d == char_N_i) {
                        // If current digit `d` matches N's digit,
                        // we mark that an exact match is possible for this position
                        // and continue to the next position with `tight` still true.
                        found_digit_equal_to_N_i = true;
                    }
                    // If char_d > char_N_i and tight is true, we cannot use this digit
                    // as it would make the number formed greater than n. Do nothing.
                }
            }

            if (tight) {
                if (!found_digit_equal_to_N_i) {
                    // If we were trying to match N's prefix (tight is true) but couldn't find
                    // a digit in `digits` that matches `char_N_i`,
                    // then no more numbers of length L starting with the current prefix
                    // can be formed that are less than or equal to n.
                    tight = false;
                    break; // Exit the loop for positions
                } else {
                    // If we found a digit that matches `char_N_i`, `tight` remains true
                    // for the next iteration to continue matching the prefix.
                    if (i == L - 1) {
                        // If we are at the last digit and successfully matched it,
                        // it means `n` itself can be formed using the given digits.
                        ans += 1;
                    }
                }
            }
        }

        return static_cast<int>(ans);
    }
};