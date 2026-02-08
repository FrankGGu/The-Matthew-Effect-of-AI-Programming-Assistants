#include <string.h>
#include <math.h>   // For fmax, though we'll use a macro for integer max
#include <limits.h> // For INT_MIN

#define MAX(a, b) ((a) > (b) ? (a) : (b))

int largestVariance(char *s) {
    int max_variance = 0;
    int n = strlen(s);

    // Iterate through all possible pairs of distinct characters (char_a, char_b)
    for (char char_a = 'a'; char_a <= 'z'; char_a++) {
        for (char char_b = 'a'; char_b <= 'z'; char_b++) {
            if (char_a == char_b) {
                continue; // Characters must be distinct
            }

            // dp_has_b: Maximum variance (count_a - count_b) ending at current position,
            //           where char_b has appeared at least once in the substring.
            //           Initialized to INT_MIN to signify that char_b has not yet appeared.
            int dp_has_b = INT_MIN;

            // dp_no_b: Maximum variance (count_a - count_b) ending at current position,
            //          where char_b has NOT appeared yet in the substring (so count_b is 0).
            //          Effectively, this tracks count_a for a segment without char_b.
            //          Initialized to 0, representing an empty segment or a segment with 0 char_a.
            int dp_no_b = 0;

            for (int k = 0; k < n; k++) {
                char current_char = s[k];

                if (current_char == char_a) {
                    dp_no_b++; // Increment count_a for segments without char_b
                    if (dp_has_b != INT_MIN) {
                        dp_has_b++; // Increment count_a for segments with char_b
                    }
                } else if (current_char == char_b) {
                    // When char_b is encountered, it affects both states:
                    // For dp_has_b:
                    // Option 1: Extend an existing dp_has_b segment (dp_has_b - 1).
                    // Option 2: Start a new dp_has_b segment by taking a dp_no_b segment
                    //           and making the current char_b the first char_b (dp_no_b - 1).
                    dp_has_b = MAX(dp_has_b - 1, dp_no_b - 1);

                    // For dp_no_b:
                    // A segment that previously had no char_b can no longer be considered "no_b"
                    // if it includes the current char_b. If its value becomes negative,
                    // it's better to start a new segment from scratch (reset to 0).
                    // This handles the Kadane's reset for segments without char_b.
                    dp_no_b = 0;
                }

                // Update the overall maximum variance.
                // dp_has_b guarantees that char_b has appeared in the substring.
                // If dp_has_b is positive, char_a must also have appeared.
                // If dp_has_b is 0 (e.g., "ab"), char_a must also have appeared.
                // If dp_has_b is negative (e.g., "abb"), char_a must also have appeared.
                // The only case where char_a might not have appeared is if dp_has_b became -1
                // from `dp_no_b - 1` where `dp_no_b` was 0 (meaning `count(a)=0`).
                // In such a case, `max_variance` will not be updated as it's initialized to 0 and -1 < 0.
                max_variance = MAX(max_variance, dp_has_b);
            }
        }
    }

    return max_variance;
}