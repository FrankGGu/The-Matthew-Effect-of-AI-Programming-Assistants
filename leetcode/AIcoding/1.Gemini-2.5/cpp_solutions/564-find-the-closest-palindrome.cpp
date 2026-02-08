#include <string>
#include <vector>
#include <algorithm>
#include <cmath>
#include <set>
#include <climits>

class Solution {
public:
    std::string nearestPalindromic(std::string n) {
        long long n_val = std::stoll(n);
        int len = n.length();

        std::set<long long> candidates_set;

        // Candidate 1: 99...9 (length L-1)
        // For n="1", L=1, pow(10,0)-1 = 0.
        candidates_set.insert((long long)std::pow(10, len - 1) - 1);

        // Candidate 2: 10...01 (length L+1)
        candidates_set.insert((long long)std::pow(10, len) + 1);

        // Candidate 3: Palindromes of length L based on prefix
        int half_len = (len + 1) / 2;
        long long prefix_num = std::stoll(n.substr(0, half_len));

        for (long long i = -1; i <= 1; ++i) {
            long long p_val = prefix_num + i;
            std::string p_str = std::to_string(p_val);

            // If the length of the prefix string changes, it means the resulting palindrome
            // will have a different number of digits than L. These are handled by L-1 or L+1 candidates.
            // Example: n="100", prefix="10", half_len=2. p_val=9, p_str="9", len=1 != half_len. Skip.
            // Example: n="99", prefix="9", half_len=1. p_val=10, p_str="10", len=2 != half_len. Skip.
            // Example: n="1", prefix="1", half_len=1. p_val=0, p_str="0", len=1 == half_len. Not skipped. Correct.
            if (p_str.length() != half_len) {
                continue;
            }

            std::string s = p_str;
            std::string reversed_suffix = p_str;
            std::reverse(reversed_suffix.begin(), reversed_suffix.end());
            s += reversed_suffix.substr(len % 2);
            candidates_set.insert(std::stoll(s));
        }

        long long min_diff = LLONG_MAX;
        long long result_palindrome = -1;

        for (long long p : candidates_set) {
            if (p == n_val) {
                continue;
            }
            long long diff = std::abs(p - n_val);
            if (diff < min_diff) {
                min_diff = diff;
                result_palindrome = p;
            } else if (diff == min_diff) {
                result_palindrome = std::min(result_palindrome, p);
            }
        }

        return std::to_string(result_palindrome);
    }
};