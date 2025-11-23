#include <string>
#include <vector>
#include <algorithm> // For std::min, though not strictly needed for substr behavior

class Solution {
public:
    // Helper to get number of digits in an integer
    // Using std::to_string is a straightforward way to do this.
    int get_digits(int n) {
        return std::to_string(n).length();
    }

    // Helper to calculate the sum of the number of digits for integers from 1 to num.
    // E.g., count_digits_sum(12) = digits(1) + digits(2) + ... + digits(9) + digits(10) + digits(11) + digits(12)
    // = (9 * 1) + (3 * 2) = 9 + 6 = 15.
    long long count_digits_sum(int num) {
        long long res = 0;
        long long power_of_10 = 1;
        int digits = 1;
        // Iterate through blocks of numbers with the same number of digits (1-9, 10-99, 100-999, etc.)
        while (power_of_10 * 10 <= num) {
            // Add digits for all numbers in the current block (e.g., 9 numbers for 1-9, 90 for 10-99)
            res += 9 * power_of_10 * digits;
            power_of_10 *= 10;
            digits++;
        }
        // Add digits for the remaining numbers in the last partial block
        res += (long long)(num - power_of_10 + 1) * digits;
        return res;
    }

    std::vector<std::string> splitMessage(std::string message, int limit) {
        int n = message.length();

        // Iterate through possible total number of parts (k)
        // k can range from 1 up to n (the maximum possible if each part contains only 1 character)
        for (int k = 1; k <= n; ++k) {
            int len_total_digits = get_digits(k);

            // Calculate the length of the suffix for the last part, which is the longest suffix: "<k/k>"
            // Suffix length = digits in k (for index) + 1 (for '/') + digits in k (for total)
            if (get_digits(k) + 1 + len_total_digits > limit) {
                // If even the longest possible suffix for this `k` exceeds the `limit`,
                // then this `k` and any larger `k` (which would have even longer or equal suffixes) are impossible.
                // We can stop searching for `k`.
                break; 
            }

            // Calculate the total number of characters available for the message chunks across all `k` parts.
            // For each part `i` (from 1 to `k`):
            //   Suffix length = get_digits(i) + 1 + len_total_digits
            //   Available chunk length = limit - (get_digits(i) + 1 + len_total_digits)
            // Summing this for `i=1` to `k`:
            //   Sum = k * (limit - 1 - len_total_digits) - sum(get_digits(i) for i=1 to k)
            long long total_available_chunk_chars = (long long)k * (limit - 1 - len_total_digits) - count_digits_sum(k);

            if (total_available_chunk_chars >= n) {
                // This `k` is the smallest possible total number of parts that can accommodate the entire message.
                // Construct the result based on this `k`.
                std::vector<std::string> result;
                int current_char_idx = 0; // Tracks the current position in the original message

                for (int i = 1; i <= k; ++i) {
                    std::string suffix = "<" + std::to_string(i) + "/" + std::to_string(k) + ">";
                    int chunk_len = limit - suffix.length();

                    // Extract the chunk from the message.
                    // substr will automatically handle cases where 'chunk_len' goes beyond the message end.
                    std::string part = message.substr(current_char_idx, chunk_len) + suffix;
                    result.push_back(part);

                    // Advance the index by the maximum possible chunk length for this part.
                    // The total_available_chunk_chars calculation assumes this.
                    current_char_idx += chunk_len;
                }
                return result;
            }
        }

        // According to LeetCode problem constraints, a solution is always guaranteed.
        // This line should theoretically not be reached if the problem statement holds.
        return {}; 
    }
};