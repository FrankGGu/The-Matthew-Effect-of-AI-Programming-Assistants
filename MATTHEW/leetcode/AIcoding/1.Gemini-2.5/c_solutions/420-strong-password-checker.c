#include <string.h> // For strlen
#include <ctype.h>  // For islower, isupper, isdigit

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

int strongPasswordChecker(char * password) {
    int n = strlen(password);

    // Part 1: Check for missing character types
    int has_lower = 0;
    int has_upper = 0;
    int has_digit = 0;

    for (int i = 0; i < n; ++i) {
        if (islower(password[i])) has_lower = 1;
        else if (isupper(password[i])) has_upper = 1;
        else if (isdigit(password[i])) has_digit = 1;
    }

    int missing_types = (has_lower ? 0 : 1) + (has_upper ? 0 : 1) + (has_digit ? 0 : 1);

    // Part 2: Calculate replacements needed for repeating characters
    int replacements_for_repeats = 0;
    int repeats_mod_3_counts[3] = {0, 0, 0}; // counts for k % 3 == 0, 1, 2

    for (int i = 0; i < n; ) {
        int j = i;
        while (j < n && password[j] == password[i]) {
            j++;
        }
        int length = j - i;
        if (length >= 3) {
            replacements_for_repeats += length / 3;
            repeats_mod_3_counts[length % 3]++;
        }
        i = j; // Move to the next distinct character
    }

    int ans = 0;

    if (n < 6) {
        // Case 1: Password is too short
        // We need to insert (6 - n) characters.
        // These insertions can also cover missing types.
        // The number of operations is the maximum of (needed length) and (missing types).
        ans = MAX(6 - n, missing_types);
    } else if (n <= 20) {
        // Case 2: Password length is within bounds
        // Operations needed are max of (replacements for repeats) and (missing types).
        ans = MAX(replacements_for_repeats, missing_types);
    } else {
        // Case 3: Password is too long (n > 20)
        // We need to delete (n - 20) characters.
        int deletions_needed = n - 20;
        ans = deletions_needed; // These deletions are part of the total operations

        // Try to use deletions to reduce replacements_for_repeats efficiently
        // Priority for deletions to save 1 replacement:
        // 1. From repeats of length 3k+1 (e.g., 4 chars): 1 deletion saves 1 replacement.
        // 2. From repeats of length 3k+2 (e.g., 5 chars): 2 deletions save 1 replacement.
        // 3. From repeats of length 3k (e.g., 6 chars): 3 deletions save 1 replacement.
        //    However, the first deletion from a 3k group also saves 1 replacement,
        //    so remaining deletions can reduce `replacements_for_repeats` 1 for 1.

        // Use deletions for k % 3 == 1 groups first (cost 1 deletion per replacement saved)
        int num_to_reduce = MIN(deletions_needed, repeats_mod_3_counts[1]);
        replacements_for_repeats -= num_to_reduce;
        deletions_needed -= num_to_reduce;

        // Use deletions for k % 3 == 2 groups next (cost 2 deletions per replacement saved)
        num_to_reduce = MIN(deletions_needed / 2, repeats_mod_3_counts[2]);
        replacements_for_repeats -= num_to_reduce;
        deletions_needed -= num_to_reduce * 2;

        // Use remaining deletions for any group, effectively 1 deletion saves 1 replacement.
        // This covers k % 3 == 0 groups where 1 deletion saves 1 replacement initially,
        // and any further deletions on other groups.
        replacements_for_repeats -= deletions_needed;
        replacements_for_repeats = MAX(0, replacements_for_repeats);

        // Add the remaining operations needed for replacements and missing types
        ans += MAX(replacements_for_repeats, missing_types);
    }

    return ans;
}