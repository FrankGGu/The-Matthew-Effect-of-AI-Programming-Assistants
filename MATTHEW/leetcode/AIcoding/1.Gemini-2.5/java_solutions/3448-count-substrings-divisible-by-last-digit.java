import java.util.HashMap;
import java.util.Map;

class Solution {
    public long countDivisibleSubstrings(String s) {
        int n = s.length();
        long ans = 0;

        // For d_j = 3, 6, 9 (sum of digits approach)
        // P_sum[k] = (s[0]-'0' + ... + s[k-1]-'0') % M
        // We need (P_sum[j] - P_sum[i]) % M == 0 => P_sum[j] == P_sum[i]
        // freq_mod3_sum stores counts of P_sum[i] for i <= j.
        // P_sum[0] (empty prefix) is 0.
        int[] freq_mod3_sum = new int[3];
        freq_mod3_sum[0] = 1; // Represents P_sum[0] = 0
        long current_prefix_val_mod3_sum = 0;

        int[] freq_mod9_sum = new int[9];
        freq_mod9_sum[0] = 1; // Represents P_sum[0] = 0
        long current_prefix_val_mod9_sum = 0;

        // For d_j = 7 (general prefix sum with modular inverse)
        // P_k = val(s[0...k])
        // We need (P_j * inv_pow10[j+1]) % 7 == (P_i * inv_pow10[i+1]) % 7
        // freq_mod7_num stores counts of (P_i * inv_pow10[i+1]) % 7 for i <= j.
        // P_{-1} = 0, inv_pow10[0] = 1. So (0 * 1) % 7 = 0.
        Map<Integer, Integer> freq_mod7_num = new HashMap<>();
        freq_mod7_num.put(0, 1); // Represents P_{-1} = 0
        long current_prefix_val_mod7_num = 0;
        long current_inv_pow10_mod7 = 1; // Represents inv_pow10[j+1] (starts as inv_pow10[0] for P_{-1})

        for (int j = 0; j < n; j++) {
            int digit = s.charAt(j) - '0';

            // Store values before updating for current digit s[j]
            // These represent prefix s[0...j-1] or P_{j-1}
            long prev_prefix_val_mod3_sum = current_prefix_val_mod3_sum;
            long prev_prefix_val_mod9_sum = current_prefix_val_mod9_sum;
            long prev_prefix_val_mod7_num = current_prefix_val_mod7_num;
            long prev_inv_pow10_mod7 = current_inv_pow10_mod7;

            // Update current values for prefix s[0...j] or P_j
            current_prefix_val_mod3_sum = (current_prefix_val_mod3_sum + digit) % 3;
            current_prefix_val_mod9_sum = (current_prefix_val_mod9_sum + digit) % 9;
            current_prefix_val_mod7_num = (current_prefix_val_mod7_num * 10 + digit) % 7;
            // Modular inverse of 10 mod 7 is 5 (since 10*5 = 50, 50 % 7 = 1)
            current_inv_pow10_mod7 = (current_inv_pow10_mod7 * 5) % 7; // This becomes inv_pow10[j+1]

            // 1. Add for substring s[j...j] (single digit substring)
            // (s[j]-'0') % (s[j]-'0') is always 0.
            ans++;

            // 2. Add for substrings s[i...j] where i < j
            // Condition: (val(s[i...j-1]) * 10) % (s[j]-'0') == 0
            if (digit == 1 || digit == 2 || digit == 5) {
                // d = 1, 2, 5. gcd(10, d) = d.
                // (val(s[i...j-1]) * (10/d)) % 1 == 0. Always true.
                // All j substrings s[0...j-1], ..., s[j-1...j-1] are valid.
                ans += j;
            } else if (digit == 3 || digit == 6) {
                // d = 3, 6. d' = 3.
                // Need val(s[i...j-1]) % 3 == 0.
                // Since 10 % 3 == 1, val(s[i...j-1]) % 3 == sum_digits(s[i...j-1]) % 3.
                // This means (P_sum[j] - P_sum[i]) % 3 == 0 => P_sum[j] == P_sum[i].
                // prev_prefix_val_mod3_sum is P_sum[j].
                ans += freq_mod3_sum[(int)prev_prefix_val_mod3_sum];
            } else if (digit == 4) {
                // d = 4. d' = 2.
                // Need val(s[i...j-1]) % 2 == 0.
                // This means the last digit of s[i...j-1] must be even, i.e., (s[j-1]-'0') % 2 == 0.
                // If this is true, all j substrings s[0...j-1], ..., s[j-1...j-1] are valid.
                if (j > 0 && (s.charAt(j - 1) - '0') % 2 == 0) {
                    ans += j;
                }
            } else if (digit == 7) {
                // d = 7. d' = 7.
                // Need val(s[i...j-1]) % 7 == 0.
                // This is P_{j-1} * inv_pow10[j] == P_{i-1} * inv_pow10[i] (mod 7).
                // The term for P_{j-1} is (prev_prefix_val_mod7_num * prev_inv_pow10_mod7) % 7.
                int term = (int)((prev_prefix_val_mod7_num * prev_inv_pow10_mod7) % 7);
                ans += freq_mod7_num.getOrDefault(term, 0);
            } else if (digit == 8) {
                // d = 8. d' = 4.
                // Need val(s[i...j-1]) % 4 == 0.
                // This depends on the last 2 digits of s[i...j-1].
                // Substring s[j-1...j-1]: check (s[j-1]-'0') % 4 == 0.
                // Substring s[i...j-1] for i < j-1: check val(s[j-2...j-1]) % 4 == 0.
                if (j > 0) {
                    int last_digit_val = s.charAt(j - 1) - '0';
                    if (last_digit_val % 4 == 0) {
                        ans++; // For substring s[j-1...j]
                    }
                    if (j > 1) {
                        int last_two_digits_val = (s.charAt(j - 2) - '0') * 10 + last_digit_val;
                        if (last_two_digits_val % 4 == 0) {
                            ans += (j - 1); // For substrings s[0...j], ..., s[j-2...j]
                        }
                    }
                }
            } else if (digit == 9) {
                // d = 9. d' = 9.
                // Need val(s[i...j-1]) % 9 == 0.
                // Since 10 % 9 == 1, val(s[i...j-1]) % 9 == sum_digits(s[i...j-1]) % 9.
                // This means (P_sum[j] - P_sum[i]) % 9 == 0 => P_sum[j] == P_sum[i].
                // prev_prefix_val_mod9_sum is P_sum[j].
                ans += freq_mod9_sum[(int)prev_prefix_val_mod9_sum];
            }

            // Update frequency maps with current values (for prefix s[0...j])
            freq_mod3_sum[(int)current_prefix_val_mod3_sum]++;
            freq_mod9_sum[(int)current_prefix_val_mod9_sum]++;
            int term_for_map = (int)((current_prefix_val_mod7_num * current_inv_pow10_mod7) % 7);
            freq_mod7_num.put(term_for_map, freq_mod7_num.getOrDefault(term_for_map, 0) + 1);
        }

        return ans;
    }
}