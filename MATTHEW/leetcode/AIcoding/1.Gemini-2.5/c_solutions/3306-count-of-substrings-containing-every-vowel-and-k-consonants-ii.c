#include <stdbool.h>
#include <string.h>

bool is_vowel(char c) {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
}

int get_vowel_idx(char c) {
    if (c == 'a') return 0;
    if (c == 'e') return 1;
    if (c == 'i') return 2;
    if (c == 'o') return 3;
    if (c == 'u') return 4;
    return -1; // Should not happen for valid vowels
}

long long solve_at_most(char *s, int k_limit) {
    int n = strlen(s);
    long long total_count = 0;

    // Pointer for the consonant constraint: s[left...right] has <= k_limit consonants
    int left = 0;
    int consonant_count = 0;

    // Frequencies and mask for the vowel constraint window: s[left_vowel_start...right]
    int vowel_freq_for_vowel_check[5] = {0};
    int current_vowel_mask_for_vowel_check = 0;
    int target_vowel_mask = (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3) | (1 << 4);

    // Pointer for the vowel constraint: s[left_vowel_start...right] has all 5 vowels
    int left_vowel_start = 0;

    for (int right = 0; right < n; ++right) {
        char c_right = s[right];

        // Update consonant count for the main window [left...right]
        if (!is_vowel(c_right)) {
            consonant_count++;
        }

        // Update vowel counts and mask for the vowel-check window [left_vowel_start...right]
        if (is_vowel(c_right)) {
            int idx = get_vowel_idx(c_right);
            vowel_freq_for_vowel_check[idx]++;
            current_vowel_mask_for_vowel_check |= (1 << idx);
        }

        // 1. Shrink `left` to satisfy `consonant_count <= k_limit`
        while (consonant_count > k_limit) {
            char c_left = s[left];
            if (!is_vowel(c_left)) {
                consonant_count--;
            }
            left++;
        }

        // 2. Adjust `left_vowel_start` to be at least `left`.
        // If `left` has moved past `left_vowel_start`, we need to advance `left_vowel_start`
        // and remove characters from its window.
        while (left_vowel_start < left) {
            char c_left_vowel = s[left_vowel_start];
            if (is_vowel(c_left_vowel)) {
                int idx = get_vowel_idx(c_left_vowel);
                vowel_freq_for_vowel_check[idx]--;
                if (vowel_freq_for_vowel_check[idx] == 0) {
                    current_vowel_mask_for_vowel_check &= ~(1 << idx);
                }
            }
            left_vowel_start++;
        }

        // 3. Shrink `left_vowel_start` to find the minimal `i` such that `s[i...right]` has all 5 vowels.
        // This loop finds the leftmost `i` (i.e., `left_vowel_start`) such that `s[i...right]` contains all required vowels.
        // It moves `left_vowel_start` forward as long as removing `s[left_vowel_start]` still leaves all vowels present.
        while (current_vowel_mask_for_vowel_check == target_vowel_mask) {
            char c_left_vowel = s[left_vowel_start];
            if (is_vowel(c_left_vowel)) {
                int idx = get_vowel_idx(c_left_vowel);
                if (vowel_freq_for_vowel_check[idx] == 1) {
                    // If removing this vowel makes the mask invalid, then `left_vowel_start` is the minimal start.
                    // We cannot shrink `left_vowel_start` further without losing a required vowel.
                    break;
                }
                vowel_freq_for_vowel_check[idx]--; // Temporarily remove to check if we can shrink further
            }
            left_vowel_start++;
        }

        // At this point, `left_vowel_start` is the minimal index `i` such that `s[i...right]` contains all 5 vowels.
        // If `current_vowel_mask_for_vowel_check == target_vowel_mask` is true, it means `s[left_vowel_start...right]`
        // (after the while loop) still contains all vowels, and `left_vowel_start` is the minimal such starting point.
        // Any starting point `i` such that `left <= i <= left_vowel_start` will satisfy both conditions:
        // 1. `s[i...right]` has `consonant_count <= k_limit` (because `i >= left`)
        // 2. `s[i...right]` has `all 5 vowels` (because `i <= left_vowel_start` and `s[left_vowel_start...right]` has all 5 vowels).
        // The number of such starting points is `left_vowel_start - left + 1`.
        if (current_vowel_mask_for_vowel_check == target_vowel_mask) {
            total_count += (long long)(left_vowel_start - left + 1);
        }
    }
    return total_count;
}

long long countSubstrings(char * s, int k) {
    // Using the principle of inclusion-exclusion:
    // (count substrings with at most K consonants) - (count substrings with at most K-1 consonants)
    return solve_at_most(s, k) - solve_at_most(s, k - 1);
}