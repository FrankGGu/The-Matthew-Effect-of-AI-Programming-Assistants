#include <vector>
#include <numeric>
#include <map>
#include <cmath>
#include <algorithm>

class Solution {
public:
    bool canPartitionIntoTwoEqualProductSubsets(std::vector<int>& nums) {
        int n = nums.size();
        if (n < 2) {
            return false;
        }

        int zero_count = 0;
        for (int x : nums) {
            if (x == 0) {
                zero_count++;
            }
        }

        if (zero_count >= 2) {
            return true;
        }
        if (zero_count == 1) {
            return false;
        }

        int total_neg_parity = 0;
        std::map<int, int> total_prime_exponents;

        for (int num : nums) {
            if (num < 0) {
                total_neg_parity++;
            }
            int temp_num = std::abs(num);
            if (temp_num == 1) continue;

            for (int p = 2; p * p <= temp_num; ++p) {
                while (temp_num % p == 0) {
                    total_prime_exponents[p]++;
                    temp_num /= p;
                }
            }
            if (temp_num > 1) {
                total_prime_exponents[temp_num]++;
            }
        }

        int current_left_neg_parity = 0;
        std::map<int, int> current_left_prime_exponents;

        for (int i = 0; i < n - 1; ++i) {
            int num = nums[i];

            if (num < 0) {
                current_left_neg_parity++;
            }
            int temp_num = std::abs(num);
            if (temp_num != 1) {
                for (int p = 2; p * p <= temp_num; ++p) {
                    while (temp_num % p == 0) {
                        current_left_prime_exponents[p]++;
                        total_prime_exponents[p]--;
                        temp_num /= p;
                    }
                }
                if (temp_num > 1) {
                    current_left_prime_exponents[temp_num]++;
                    total_prime_exponents[temp_num]--;
                }
            }

            for (auto it = total_prime_exponents.begin(); it != total_prime_exponents.end(); ) {
                if (it->second == 0) {
                    it = total_prime_exponents.erase(it);
                } else {
                    ++it;
                }
            }

            int current_right_neg_parity = total_neg_parity - current_left_neg_parity;

            if ((current_left_neg_parity % 2 == current_right_neg_parity % 2) &&
                (current_left_prime_exponents == total_prime_exponents)) {
                return true;
            }
        }

        return false;
    }
};