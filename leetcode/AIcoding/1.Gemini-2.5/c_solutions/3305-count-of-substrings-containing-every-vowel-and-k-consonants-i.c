#include <string.h>
#include <stdbool.h>
#include <stdlib.h> // For memcpy

static inline int get_vowel_idx(char c) {
    switch (c) {
        case 'a': return 0;
        case 'e': return 1;
        case 'i': return 2;
        case 'o': return 3;
        case 'u': return 4;
        default: return -1;
    }
}

long long count_valid_substrings_with_max_consonants(char* s, int k_max_consonants) {
    int n = strlen(s);
    long long total_count = 0;
    int l = 0; // Left pointer of the main sliding window
    int vowel_freq[5] = {0}; // Frequency of each vowel in the current window s[l...r]
    int distinct_vowels = 0; // Count of distinct vowels in the current window s[l...r]
    int current_consonants = 0; // Count of consonants in the current window s[l...r]

    // Iterate with the right pointer 'r'
    for (int r = 0; r < n; ++r) {
        // Add s[r] to the window
        int v_idx = get_vowel_idx(s[r]);
        if (v_idx != -1) { // It's a vowel
            if (vowel_freq[v_idx] == 0) {
                distinct_vowels++;
            }
            vowel_freq[v_idx]++;
        } else { // It's a consonant
            current_consonants++;
        }

        // Shrink the window from the left ('l') if conditions are violated:
        // 1. Consonant count exceeds k_max_consonants.
        // 2. (Implicitly handled by the 'if (distinct_vowels == 5)' check later)
        // The loop ensures that s[l...r] always has current_consonants <= k_max_consonants.
        while (l <= r && current_consonants > k_max_consonants) {
            int lv_idx = get_vowel_idx(s[l]);
            if (lv_idx != -1) { // It's a vowel
                vowel_freq[lv_idx]--;
                if (vowel_freq[lv_idx] == 0) {
                    distinct_vowels--;
                }
            } else { // It's a consonant
                current_consonants--;
            }
            l++;
        }

        // At this point, the window s[l...r] satisfies the consonant count condition:
        // current_consonants <= k_max_consonants.
        // Now, we need to check the vowel condition: distinct_vowels == 5.
        if (distinct_vowels == 5) {
            // If the current window s[l...r] has all 5 vowels and <= k_max_consonants,
            // we need to find how many valid starting positions 'i' exist for substrings s[i...r].
            // A valid 'i' must satisfy:
            // 1. i >= l (to maintain current_consonants <= k_max_consonants)
            // 2. s[i...r] must contain all 5 vowels.

            // To satisfy condition 2, we find the leftmost 'temp_l' such that s[temp_l...r]
            // contains all 5 vowels. This is done by further shrinking the window from 'l'
            // as long as removing s[temp_l] does not break the 'all 5 vowels' condition.
            int temp_l = l;
            int temp_vowel_freq[5];
            memcpy(temp_vowel_freq, vowel_freq, sizeof(vowel_freq)); // Use a copy for inner loop

            while (temp_l <= r) {
                int lv_idx = get_vowel_idx(s[temp_l]);
                if (lv_idx != -1 && temp_vowel_freq[lv_idx] > 1) { // If this vowel is redundant
                    temp_vowel_freq[lv_idx]--;
                    temp_l++;
                } else {
                    break; // Cannot remove s[temp_l] without losing a distinct vowel
                }
            }

            // 'temp_l' is now the leftmost index such that s[temp_l...r] has all 5 vowels.
            // Any starting index 'i' between 'l' and 'temp_l' (inclusive) will form a substring s[i...r]
            // that satisfies both conditions:
            // - It has all 5 vowels (because s[temp_l...r] has them, and s[i...r] for i < temp_l contains more elements).
            // - It has current_consonants <= k_max_consonants (because 'l' already ensures this, and i >= l).
            // The number of such starting positions 'i' is (temp_l - l + 1).
            total_count += (temp_l - l + 1);
        }
    }
    return total_count;
}

long long countSubstrings(char* s, int k) {
    // The problem asks for substrings containing EXACTLY K consonants.
    // This can be solved using the principle of inclusion-exclusion:
    // (Count of substrings with all 5 vowels and AT MOST K consonants)
    // - (Count of substrings with all 5 vowels and AT MOST K-1 consonants)

    // If k-1 is negative, it means we are looking for substrings with < 0 consonants,
    // which is impossible. In this case, count_valid_substrings_with_max_consonants(s, -1)
    // should correctly return 0.
    return count_valid_substrings_with_max_consonants(s, k) - 
           count_valid_substrings_with_max_consonants(s, k - 1);
}