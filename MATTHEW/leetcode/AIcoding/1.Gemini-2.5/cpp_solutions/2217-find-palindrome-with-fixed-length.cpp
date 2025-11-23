#include <vector>
#include <string>
#include <algorithm>
#include <cmath>

class Solution {
public:
    std::vector<long long> kthPalindrome(std::vector<int>& queries, int intLength) {
        std::vector<long long> results;

        long long first_half_len = (intLength + 1) / 2;

        long long start_num = static_cast<long long>(std::pow(10, first_half_len - 1));
        long long end_num = static_cast<long long>(std::pow(10, first_half_len)) - 1;

        for (int q : queries) {
            long long candidate_first_half = start_num + q - 1;

            if (candidate_first_half > end_num) {
                results.push_back(-1);
                continue;
            }

            std::string s_first_half = std::to_string(candidate_first_half);
            std::string s_second_half = s_first_half;
            std::reverse(s_second_half.begin(), s_second_half.end());

            std::string palindrome_str;
            if (intLength % 2 == 1) {
                palindrome_str = s_first_half + s_second_half.substr(1);
            } else {
                palindrome_str = s_first_half + s_second_half;
            }

            results.push_back(std::stoll(palindrome_str));
        }

        return results;
    }
};