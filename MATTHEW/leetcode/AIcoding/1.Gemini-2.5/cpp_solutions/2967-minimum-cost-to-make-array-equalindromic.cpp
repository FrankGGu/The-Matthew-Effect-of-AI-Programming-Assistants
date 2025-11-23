#include <vector>
#include <string>
#include <algorithm>
#include <cmath>
#include <set>

class Solution {
public:
    long long calculateCost(const std::vector<int>& nums, long long p) {
        long long currentCost = 0;
        for (int num : nums) {
            currentCost += std::abs(static_cast<long long>(num) - p);
        }
        return currentCost;
    }

    std::vector<long long> generatePalindromes() {
        std::set<long long> pals_set;
        const long long MAX_PALINDROME_VALUE = 2000000000LL;

        for (long long i = 1; i <= 9; ++i) {
            pals_set.insert(i);
        }

        for (long long i = 1; i <= 100000; ++i) {
            std::string s = std::to_string(i);
            std::string rs = s;
            std::reverse(rs.begin(), rs.end());

            // Even length palindromes
            std::string even_s = s + rs;
            if (even_s.length() <= 10) { 
                long long p_even = std::stoll(even_s);
                if (p_even <= MAX_PALINDROME_VALUE) {
                    pals_set.insert(p_even);
                }
            }

            // Odd length palindromes
            std::string odd_s = s + rs.substr(1);
            if (odd_s.length() <= 10) {
                long long p_odd = std::stoll(odd_s);
                if (p_odd <= MAX_PALINDROME_VALUE) {
                    pals_set.insert(p_odd);
                }
            }
        }

        return std::vector<long long>(pals_set.begin(), pals_set.end());
    }

    long long minimumCost(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        int n = nums.size();

        long long median_val = nums[n / 2];

        std::vector<long long> all_palindromes = generatePalindromes();

        long long minTotalCost = -1;

        auto it = std::lower_bound(all_palindromes.begin(), all_palindromes.end(), median_val);

        int check_range = 50; 

        for (int i = -check_range; i <= check_range; ++i) {
            auto current_it = it + i;
            if (current_it >= all_palindromes.begin() && current_it < all_palindromes.end()) {
                long long p = *current_it;
                long long currentCost = calculateCost(nums, p);
                if (minTotalCost == -1 || currentCost < minTotalCost) {
                    minTotalCost = currentCost;
                }
            }
        }

        return minTotalCost;
    }
};