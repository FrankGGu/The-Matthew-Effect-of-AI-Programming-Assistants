#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

char* smallestSubsequence(char* s, int k, char letter, int occurrence) {
    int n = strlen(s);

    // Precompute suffix_letter_counts: count of 'letter' in s[i...n-1]
    // suffix_letter_counts[i] stores the count of 'letter' in the substring s[i...n-1]
    int* suffix_letter_counts = (int*)malloc((n + 1) * sizeof(int));
    if (suffix_letter_counts == NULL) {
        return NULL; // Handle allocation failure
    }
    suffix_letter_counts[n] = 0; // Base case: no letters after index n-1
    for (int i = n - 1; i >= 0; i--) {
        suffix_letter_counts[i] = suffix_letter_counts[i + 1] + (s[i] == letter ? 1 : 0);
    }

    // ans_arr acts as a stack to build the subsequence
    char* ans_arr = (char*)malloc((k + 1) * sizeof(char));
    if (ans_arr == NULL) {
        free(suffix_letter_counts);
        return NULL; // Handle allocation failure
    }
    int ans_len = 0; // Current length of the subsequence in ans_arr
    int current_letter_count = 0; // Count of 'letter' in ans_arr

    for (int i = 0; i < n; i++) {
        char char_s_i = s[i];

        // Step 1: Pop from ans_arr if possible and beneficial (lexicographically smaller)
        // We pop if:
        // 1. The stack is not empty.
        // 2. The current character `char_s_i` is smaller than the top of the stack.
        // 3. Popping the top character is "safe" regarding length `k` and `occurrence` constraints.
        while (ans_len > 0 && ans_arr[ans_len - 1] > char_s_i) {
            // Safety condition 1: Enough total characters remaining to form length `k`.
            // `ans_len - 1` (after pop) + `(n - i)` (chars from s[i] onwards, including s[i]) must be >= `k`.
            if (ans_len - 1 + (n - i) < k) {
                break; // Cannot pop, would make it impossible to reach length k
            }

            // Safety condition 2: Enough 'letter's remaining to meet 'occurrence'.
            // `current_letter_count - (ans_arr[ans_len-1] == letter ? 1 : 0)` (count after pop)
            // + `suffix_letter_counts[i]` (available 'letter's from s[i] onwards) must be >= `occurrence`.
            if (current_letter_count - (ans_arr[ans_len - 1] == letter ? 1 : 0) + suffix_letter_counts[i] < occurrence) {
                break; // Cannot pop, would make it impossible to reach 'occurrence' count
            }

            // If both safety conditions met, pop the character.
            if (ans_arr[ans_len - 1] == letter) {
                current_letter_count--;
            }
            ans_len--;
        }

        // Step 2: Add char_s_i to ans_arr if possible.
        // We add if:
        // 1. The subsequence `ans_arr` is not yet of length `k`.
        if (ans_len < k) {
            if (char_s_i == letter) {
                // If `char_s_i` is the target `letter`, add it if we still need more `letter`s.
                if (current_letter_count < occurrence) {
                    ans_arr[ans_len++] = char_s_i;
                    current_letter_count++;
                }
            } else { // char_s_i != letter
                // If `char_s_i` is not the target `letter`, add it if:
                // Condition 1: We can still meet `occurrence` even if we pick this non-letter.
                // This means `current_letter_count` (letters already in `ans_arr`)
                // + `suffix_letter_counts[i]` (letters available from `s[i]` onwards) must be >= `occurrence`.
                // Condition 2: After adding this non-letter, there are enough remaining slots
                // in the subsequence (to reach length `k`) for the 'letter's still needed.
                // `k - (ans_len + 1)` (slots remaining after adding `char_s_i`)
                // must be >= `occurrence - current_letter_count` (letters still needed).
                // This can be rewritten as: `(k - ans_len) - (occurrence - current_letter_count) >= 1`.
                // This means, among the `k - ans_len` slots we still need to fill,
                // at least one slot can be a non-letter (which `char_s_i` is).
                if (current_letter_count + suffix_letter_counts[i] >= occurrence &&
                    (k - ans_len) - (occurrence - current_letter_count) >= 1) {
                    ans_arr[ans_len++] = char_s_i;
                }
            }
        }
    }

    ans_arr[ans_len] = '\0'; // Null-terminate the result string

    free(suffix_letter_counts);
    return ans_arr;
}