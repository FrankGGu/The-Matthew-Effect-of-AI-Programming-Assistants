#include <string>
#include <algorithm>
#include <cmath>
#include <iomanip>

class Solution {
public:
    std::string abbreviateProduct(int left, int right) {
        long double log_prod = 0.0L;
        long long current_suffix = 1LL;
        long double current_prefix_ld = 1.0L;

        const long long MOD_SUFFIX = 100000LL;
        // Keep current_prefix_ld below this threshold to maintain precision.
        // If long double typically offers about 18-19 decimal digits of precision,
        // and 'i' can be up to 10^9 (9 digits), then current_prefix_ld * i can have up to 19 + 9 = 28 digits.
        // To avoid excessive precision loss, current_prefix_ld should be scaled down such that
        // current_prefix_ld * i fits within the precision limits.
        // A threshold of 1e10L ensures current_prefix_ld is kept to roughly 10 digits.
        // Then current_prefix_ld * i (max 1e10 * 1e9 = 1e19) will be around 19-20 digits,
        // which is manageable for long double's typical precision.
        const long double PREFIX_THRESHOLD = 1e10L; 

        for (int i = left; i <= right; ++i) {
            log_prod += std::log10(static_cast<long double>(i));

            current_suffix = (current_suffix * i) % MOD_SUFFIX;

            current_prefix_ld *= i;
            while (current_prefix_ld >= PREFIX_THRESHOLD) {
                current_prefix_ld /= 10.0L;
            }
        }

        long long total_digits = static_cast<long long>(std::floor(log_prod)) + 1;

        if (total_digits <= 10) {
            long long exact_prod = 1LL;
            for (int i = left; i <= right; ++i) {
                exact_prod *= i;
            }
            return std::to_string(exact_prod);
        } else {
            // Extract prefix: current_prefix_ld needs to be scaled to 5 digits.
            // First, ensure current_prefix_ld has at least 5 digits before truncating.
            // Example: if current_prefix_ld is 8.7178, scale it up to 87178.0.
            while (current_prefix_ld < 10000.0L) { 
                current_prefix_ld *= 10.0L;
            }
            long long final_prefix = static_cast<long long>(current_prefix_ld);
            // Then, if it's more than 5 digits (e.g., 123456), scale down to 5 digits.
            while (final_prefix >= 100000LL) { 
                final_prefix /= 10LL;
            }

            // Format suffix: pad with leading zeros if needed to ensure 5 digits.
            std::string suffix_str = std::to_string(current_suffix);
            while (suffix_str.length() < 5) {
                suffix_str = "0" + suffix_str;
            }

            return std::to_string(final_prefix) + "..." + suffix_str + "e" + std::to_string(total_digits);
        }
    }
};