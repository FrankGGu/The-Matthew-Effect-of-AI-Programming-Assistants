#include <string.h> // For strlen

char * replaceQuestionMarks(char * s) {
    int initial_freq[26] = {0};
    int num_q = 0;
    int len = strlen(s);

    // Step 1: Count initial frequencies of non-'?' characters and total '?' count
    for (int i = 0; i < len; i++) {
        if (s[i] == '?') {
            num_q++;
        } else {
            initial_freq[s[i] - 'a']++;
        }
    }

    // Step 2: Greedily assign characters to '?' to minimize total value
    int assigned_freq[26] = {0};
    for (int k = 0; k < num_q; k++) {
        long long min_marginal_cost = -1;
        int min_char_idx = -1;

        for (int i = 0; i < 26; i++) {
            // current_total_freq is initial_freq + assigned_freq for this character type
            long long current_total_freq = initial_freq[i] + assigned_freq[i];
            // Marginal cost of adding one more instance of character 'a' + i
            // Formula: (i+1) * (2 * current_total_freq + 1)
            long long cost = (long long)(i + 1) * (2 * current_total_freq + 1);

            if (min_char_idx == -1 || cost < min_marginal_cost) {
                min_marginal_cost = cost;
                min_char_idx = i;
            }
        }
        assigned_freq[min_char_idx]++;
    }

    // Step 3: Replace '?' in the string with the assigned characters
    int current_char_to_assign_idx = 0;
    int current_char_to_assign_count = 0; // How many of current_char_to_assign_idx are left to assign

    for (int i = 0; i < len; i++) {
        if (s[i] == '?') {
            // Find the next character type that has assignments left
            while (current_char_to_assign_idx < 26 && current_char_to_assign_count == 0) {
                current_char_to_assign_count = assigned_freq[current_char_to_assign_idx];
                if (current_char_to_assign_count == 0) { // If this char has no assignments, move to next
                    current_char_to_assign_idx++;
                }
            }

            // If we found a character to assign (should always happen if num_q > 0)
            if (current_char_to_assign_idx < 26) {
                s[i] = (char)('a' + current_char_to_assign_idx);
                current_char_to_assign_count--;
            }
        }
    }

    return s;
}