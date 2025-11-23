import java.util.ArrayList;
import java.util.List;

class Solution {
    public String[] splitMessage(String message, int limit) {
        int L_msg = message.length();

        long final_n = -1;
        int final_k = -1;

        // Iterate through possible number of digits for 'n' (total parts)
        // k represents the number of digits in 'n'
        // Max L_msg is 10^5, so max n could be around 10^5 (if each part takes 1 char).
        // The number of digits for 10^5 is 6. We can iterate k from 1 up to 7 for safety.
        for (int k = 1; k <= 7; k++) { 
            // current_low_n: smallest number with k digits (e.g., 1 for k=1, 10 for k=2)
            // current_high_n: largest number with k digits (e.g., 9 for k=1, 99 for k=2)
            long current_low_n = (long) Math.pow(10, k - 1);
            long current_high_n = (long) Math.pow(10, k) - 1;

            // The total number of parts 'n' cannot exceed the message length (if each part takes at least 1 char)
            // Nor can it exceed the maximum value for an int if we were to convert it to String.valueOf(n)
            // A safe upper bound for n is L_msg.
            current_high_n = Math.min(current_high_n, L_msg); 

            if (current_low_n > current_high_n) {
                continue; // No valid n in this k-digit range
            }

            long bs_low = current_low_n;
            long bs_high = current_high_n;
            long best_n_for_k = -1;

            // Binary search for 'n' within the current 'k' digit range
            while (bs_low <= bs_high) {
                long mid_n = bs_low + (bs_high - bs_low) / 2;

                long chars_fit_total = 0;
                long current_i_digits = 1; // Number of digits for current part number 'i'
                long threshold_i = 9;      // Upper bound for 'i' with current_i_digits (9, 99, 999, ...)
                long i_start = 1;          // Starting 'i' for current digit group

                // Calculate total characters that can be fit for 'mid_n' parts
                while (i_start <= mid_n) {
                    long num_parts_in_this_digit_group = Math.min(mid_n, threshold_i) - i_start + 1;

                    // Overhead for suffix: digits(i) + digits(n) + 3 (for '(', '/', ')')
                    long overhead_per_part = current_i_digits + k + 3;

                    if (limit <= overhead_per_part) {
                        chars_fit_total = -1; // Cannot fit any text for this configuration, indicates failure
                        break;
                    }

                    long chars_per_part = limit - overhead_per_part;
                    chars_fit_total += num_parts_in_this_digit_group * chars_per_part;

                    // Check for overflow. If chars_fit_total overflows, it means it's definitely enough characters.
                    if (chars_fit_total < 0) { 
                        chars_fit_total = Long.MAX_VALUE; 
                        break;
                    }

                    i_start = threshold_i + 1;
                    current_i_digits++;

                    // Update threshold_i for the next digit group
                    if (threshold_i > Long.MAX_VALUE / 10) { // Prevent overflow for threshold_i
                        threshold_i = Long.MAX_VALUE;
                    } else {
                        threshold_i = threshold_i * 10 + 9;
                    }
                }

                if (chars_fit_total >= L_msg && chars_fit_total != -1) {
                    best_n_for_k = mid_n;
                    bs_high = mid_n - 1; // Try smaller n to find the minimum
                } else {
                    bs_low = mid_n + 1; // Need larger n
                }
            }

            if (best_n_for_k != -1) {
                final_n = best_n_for_k;
                final_k = k;
                break; // Found the smallest n for this k, which is the overall smallest n
            }
        }

        if (final_n == -1) {
            return new String[0]; // Impossible to split
        }

        // Construct the result array using the found final_n and final_k
        String[] result = new String[(int) final_n];
        int current_msg_idx = 0;
        String n_str = String.valueOf(final_n);

        for (int i = 1; i <= final_n; i++) {
            String i_str = String.valueOf(i);
            String suffix = "(" + i_str + "/" + n_str + ")";
            int suffix_len = suffix.length();

            // Maximum text length allowed for this part
            int text_len_max = limit - suffix_len;

            // Actual text length to take from the message, ensuring not to exceed message bounds
            int actual_text_len = Math.min(text_len_max, L_msg - current_msg_idx);

            String part_text = message.substring(current_msg_idx, current_msg_idx + actual_text_len);
            result[i - 1] = part_text + suffix;
            current_msg_idx += actual_text_len;
        }

        return result;
    }
}