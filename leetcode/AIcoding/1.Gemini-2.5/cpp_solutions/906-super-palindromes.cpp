#include <string>
#include <algorithm>
#include <vector>

class Solution {
public:
    bool isPalindrome(long long n) {
        std::string s = std::to_string(n);
        int len = s.length();
        for (int i = 0; i < len / 2; ++i) {
            if (s[i] != s[len - 1 - i]) {
                return false;
            }
        }
        return true;
    }

    int superpalindromesInRange(std::string L, std::string R) {
        long long L_num = std::stoll(L);
        long long R_num = std::stoll(R);
        int count = 0;

        // Iterate through the first half of palindromes (i)
        // We need to generate palindromes 'x' such that x*x is in [L_num, R_num].
        // The maximum R_num is 10^18, so the maximum x is sqrt(10^18) = 10^9.
        //
        // For odd-length palindromes 'x': x = s + reverse(s.substr(1))
        // If x has 9 digits (max for x <= 10^9), its first half 's' has 5 digits.
        // The largest 5-digit number is 99999. So 'i' can go up to 99999.
        // (e.g., i=99999 generates x=999999999)
        //
        // For even-length palindromes 'x': x = s + reverse(s)
        // If x has 8 digits (max for x <= 10^9), its first half 's' has 4 digits.
        // The largest 4-digit number is 9999. So 'i' can go up to 9999 for even-length.
        // (e.g., i=9999 generates x=99999999)
        //
        // Therefore, 'i' needs to iterate from 1 up to 99999.
        // The loop will break early if x*x exceeds R_num.

        for (long long i = 1; i < 100000; ++i) { 
            std::string s = std::to_string(i);
            std::string rs = s;
            std::reverse(rs.begin(), rs.end());

            // Case 1: Odd length palindrome x
            // Example: i = "123" -> x = "12321"
            std::string x_str_odd = s + rs.substr(1);
            long long x_odd = std::stoll(x_str_odd);

            long long sq_odd = x_odd * x_odd;

            // Optimization: If sq_odd is already greater than R_num,
            // then any subsequent x_odd (from larger i) will also be larger.
            // Also, x_even (from current i) is always larger than x_odd (for i > 1, or i=1 where x_odd=1, x_even=11).
            // So we can break from the loop entirely.
            if (sq_odd > R_num) {
                break;
            }

            // Check if sq_odd is a super palindrome
            if (sq_odd >= L_num && isPalindrome(sq_odd)) {
                count++;
            }

            // Case 2: Even length palindrome x
            // Example: i = "123" -> x = "123321"
            // Only generate x_even if 'i' is small enough that 'x_even' itself does not exceed 10^9.
            // The maximum 'i' for 'x_even' to be <= 10^9 is 9999 (generating 99999999).
            if (i < 10000) { 
                std::string x_str_even = s + rs;
                long long x_even = std::stoll(x_str_even);

                long long sq_even = x_even * x_even;

                // Check if sq_even is a super palindrome
                // No need for an early break here, as the sq_odd check covers it.
                if (sq_even >= L_num && sq_even <= R_num && isPalindrome(sq_even)) {
                    count++;
                }
            }
        }

        return count;
    }
};