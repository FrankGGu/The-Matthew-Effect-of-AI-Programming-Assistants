#include <vector>
#include <numeric>
#include <algorithm>
#include <cmath>

class Solution {
    static const int MAX_LEN = 60;

    long long countSetBitsUpTo(long long n) {
        if (n <= 0) return 0;
        long long ans = 0;
        long long ones = 0;
        for (int i = 62; i >= 0; --i) {
            if ((n >> i) & 1) {
                if (i > 0) {
                    ans += (1LL << (i - 1)) * i;
                }
                ans += ones * (1LL << i);
                ones++;
            }
        }
        ans += ones;
        return ans;
    }

    long long countTotalZerosUpTo(long long k, const std::vector<long long>& p_bits, const std::vector<long long>& p_zeros) {
        if (k < 0) return 0;

        auto it = std::upper_bound(p_bits.begin() + 1, p_bits.end(), k);
        int len = std::distance(p_bits.begin(), it);

        long long zeros_count = p_zeros[len - 1];
        long long elements_in_block = k - p_bits[len - 1] + 1;

        long long num_full_count = elements_in_block / len;
        long long bits_partial_count = elements_in_block % len;

        long long start_num = (1LL << (len - 1));

        if (num_full_count > 0) {
            long long end_num_full = start_num + num_full_count - 1;
            long long total_bits_full = num_full_count * len;
            long long total_ones_full = countSetBitsUpTo(end_num_full) - countSetBitsUpTo(start_num - 1);
            zeros_count += total_bits_full - total_ones_full;
        }

        if (bits_partial_count > 0) {
            long long current_num = start_num + num_full_count;
            long long num_copy = current_num >> (len - bits_partial_count);
            long long ones_partial = __builtin_popcountll(num_copy);
            long long zeros_partial = bits_partial_count - ones_partial;
            zeros_count += zeros_partial;
        }

        return zeros_count;
    }

public:
    std::vector<int> findProductsOfElements(std::vector<std::vector<long long>>& queries) {
        static std::vector<long long> prefix_bit_counts(MAX_LEN + 1, 0);
        static std::vector<long long> prefix_zero_counts(MAX_LEN + 1, 0);
        static bool precomputed = false;

        if (!precomputed) {
            for (int len = 1; len <= MAX_LEN; ++len) {
                long long num_count = 1LL << (len - 1);
                long long bits_in_block = num_count * len;
                prefix_bit_counts[len] = prefix_bit_counts[len - 1] + bits_in_block;

                long long zeros_in_block = 0;
                if (len > 1) {
                    zeros_in_block = (len - 1) * (1LL << (len - 2));
                }
                prefix_zero_counts[len] = prefix_zero_counts[len - 1] + zeros_in_block;
            }
            precomputed = true;
        }

        std::vector<int> results;
        results.reserve(queries.size());
        for (const auto& q : queries) {
            long long l = q[0], r = q[1], mod = q[2];
            if (mod == 1) {
                results.push_back(0);
                continue;
            }
            long long zeros_in_range = countTotalZerosUpTo(r, prefix_bit_counts, prefix_zero_counts) - countTotalZerosUpTo(l - 1, prefix_bit_counts, prefix_zero_counts);
            if (zeros_in_range > 0) {
                results.push_back(0);
            } else {
                results.push_back(1);
            }
        }
        return results;
    }
};