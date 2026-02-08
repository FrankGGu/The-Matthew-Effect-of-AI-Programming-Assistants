#include <string>
#include <vector>
#include <algorithm>
#include <numeric>
#include <functional>

std::string get_smallest_palindrome_t(int n_t, int target_oneBit) {
    // If target_oneBit is negative or exceeds the maximum possible '1's, it's impossible.
    if (target_oneBit < 0 || target_oneBit > n_t) {
        return "";
    }

    // Case 1: n_t is even
    if (n_t % 2 == 0) {
        if (target_oneBit % 2 != 0) { // Total '1's must be even for an even length palindrome
            return "";
        }
        int ones_in_half = target_oneBit / 2;
        int half_len = n_t / 2; // Length of the first half

        if (ones_in_half > half_len) { // Not enough space in the first half
            return "";
        }

        std::string t(n_t, '0');
        // To make 't' lexicographically smallest, place '1's as far right as possible
        // in the first half (which mirrors to the second half).
        // Example: for half_len=3, ones=1, the first half should be "001".
        for (int i = half_len - 1; i >= 0; --i) {
            if (ones_in_half == 0) break;
            t[i] = '1';
            t[n_t - 1 - i] = '1';
            ones_in_half--;
        }
        return t;
    } 
    // Case 2: n_t is odd
    else {
        int middle_idx = n_t / 2; // Index of the middle character
        int half_len_excluding_middle = n_t / 2; // Length of the first half excluding the middle char

        // Try to place '0' in the middle (lexicographically smaller option)
        if (target_oneBit % 2 == 0) { // If middle is '0', the remaining '1's must be even
            int ones_in_outer_half = target_oneBit / 2; // '1's to place in t[0...half_len_excluding_middle-1]
            if (ones_in_outer_half <= half_len_excluding_middle) { // Enough space in the part excluding middle
                std::string t_candidate_0(n_t, '0'); // Middle char is already '0'
                // Place '1's as far right as possible in the outer half
                for (int i = half_len_excluding_middle - 1; i >= 0; --i) {
                    if (ones_in_outer_half == 0) break;
                    t_candidate_0[i] = '1';
                    t_candidate_0[n_t - 1 - i] = '1';
                    ones_in_outer_half--;
                }
                return t_candidate_0;
            }
        }

        // If middle '0' didn't work or wasn't possible, try middle '1'
        if (target_oneBit % 2 == 1) { // If middle is '1', the remaining '1's must be odd
            std::string t_candidate_1(n_t, '0');
            t_candidate_1[middle_idx] = '1'; // Set middle character to '1'
            int ones_for_outer_half = (target_oneBit - 1) / 2; // '1's to place in t[0...half_len_excluding_middle-1]
            if (ones_for_outer_half <= half_len_excluding_middle) { // Enough space
                // Place '1's as far right as possible in the outer half
                for (int i = half_len_excluding_middle - 1; i >= 0; --i) {
                    if (ones_for_outer_half == 0) break;
                    t_candidate_1[i] = '1';
                    t_candidate_1[n_t - 1 - i] = '1';
                    ones_for_outer_half--;
                }
                return t_candidate_1;
            }
        }
    }

    return ""; // No valid 't' found for this n_t and target_oneBit
}

class Solution {
public:
    std::string shortestBeautifulSubstring(std::string s, int k, int oneBit) {
        // The input string 's' from the function signature is not used
        // based on the provided problem description.
        // 'k' refers to the target length of the beautiful string.
        // 'oneBit' refers to the target number of '1's in the repeating unit 't'.

        std::string final_beautiful_string = "";

        // Iterate n_t (length of the repeating unit 't') from 1 to k.
        // We want the "shortest" beautiful string, which implies finding the smallest n_t first.
        for (int n_t = 1; n_t <= k; ++n_t) {
            if (k % n_t != 0) { // n_t must be a divisor of k
                continue;
            }

            // Find the lexicographically smallest palindrome 't' for the current n_t
            std::string t = get_smallest_palindrome_t(n_t, oneBit);

            if (!t.empty()) { // If a valid 't' is found
                // Construct the beautiful string by repeating 't'
                std::string current_beautiful_string = "";
                int num_copies = k / n_t;
                for (int i = 0; i < num_copies; ++i) {
                    current_beautiful_string += t;
                }

                // Since we iterate n_t from smallest to largest, the first valid 't' found
                // will result in the "shortest" beautiful string (smallest n_t).
                // The get_smallest_palindrome_t function ensures 't' itself is lexicographically smallest.
                final_beautiful_string = current_beautiful_string;
                break; // Found the optimal answer, exit the n_t loop
            }
        }

        return final_beautiful_string;
    }
};