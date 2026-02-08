#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h> // For pow, though manual loop is safer for long long powers of 10

long long build_pal(long long prefix, int len) {
    char s[20];
    sprintf(s, "%lld", prefix);
    int prefix_len = strlen(s);

    char pal_chars[20];
    int k = 0;

    // Copy the prefix to the palindrome string
    for (int i = 0; i < prefix_len; ++i) {
        pal_chars[k++] = s[i];
    }

    // Determine the starting index for mirroring
    // If total length is odd, skip the middle digit of the prefix
    // If total length is even, mirror all digits of the prefix
    int start_mirror_idx;
    if (len % 2 == 1) {
        start_mirror_idx = prefix_len - 2;
    } else {
        start_mirror_idx = prefix_len - 1;
    }

    // Mirror the digits from the prefix
    for (int i = start_mirror_idx; i >= 0; --i) {
        pal_chars[k++] = s[i];
    }
    pal_chars[k] = '\0'; // Null-terminate the string

    return atoll(pal_chars);
}

char* closestPalindrome(char* n) {
    long long N = atoll(n);
    int len = strlen(n);

    // Store candidate palindromes
    // We expect at most 5 candidates:
    // 1. Palindrome from N's first half
    // 2. Palindrome from (N's first half - 1)
    // 3. Palindrome from (N's first half + 1)
    // 4. All 9s (e.g., 9, 99, 999... for length len-1)
    // 5. 1 followed by zeros and 1 (e.g., 11, 101, 1001... for length len+1)
    long long candidates[5];
    int count = 0;

    // 1. Generate candidates based on the first half of N
    char prefix_str[20];
    strncpy(prefix_str, n, (len + 1) / 2);
    prefix_str[(len + 1) / 2] = '\0';
    long long prefix = atoll(prefix_str);

    candidates[count++] = build_pal(prefix, len);
    candidates[count++] = build_pal(prefix - 1, len);
    candidates[count++] = build_pal(prefix + 1, len);

    // 2. Candidate for length len-1 (e.g., N="100" -> "99")
    long long all_nines = 1;
    for (int i = 0; i < len - 1; ++i) {
        all_nines *= 10;
    }
    all_nines--;
    if (all_nines >= 0) { // Ensure it's not negative (only happens for len=0, which is not possible)
        candidates[count++] = all_nines;
    }

    // 3. Candidate for length len+1 (e.g., N="99" -> "101")
    long long one_zero_one = 1;
    for (int i = 0; i < len; ++i) {
        one_zero_one *= 10;
    }
    one_zero_one++;
    candidates[count++] = one_zero_one;

    long long min_diff = -1; // Use -1 to indicate not initialized
    long long result_pal = -1;

    for (int i = 0; i < count; ++i) {
        long long current_pal = candidates[i];

        // Skip the number itself
        if (current_pal == N) {
            continue;
        }

        long long diff = current_pal > N ? current_pal - N : N - current_pal;

        if (min_diff == -1 || diff < min_diff) {
            min_diff = diff;
            result_pal = current_pal;
        } else if (diff == min_diff) {
            // If differences are equal, choose the smaller palindrome
            if (current_pal < result_pal) {
                result_pal = current_pal;
            }
        }
    }

    // Convert the result long long to a string
    char* res_str = (char*)malloc(20 * sizeof(char)); // Max 18 digits + null terminator
    sprintf(res_str, "%lld", result_pal);
    return res_str;
}