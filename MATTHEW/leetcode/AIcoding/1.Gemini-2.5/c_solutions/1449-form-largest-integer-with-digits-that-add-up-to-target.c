#include <stdlib.h> // For malloc, free, strdup
#include <string.h> // For strlen, strcpy, strcmp

int compare_num_strings(const char* s1, const char* s2) {
    size_t len1 = strlen(s1);
    size_t len2 = strlen(s2);

    if (len1 != len2) {
        return (int)(len1 - len2); // Longer string represents a larger number
    }
    return strcmp(s1, s2); // Lexicographical comparison for same length
}

char* largestNumber(int* cost, int costSize, int target) {
    // dp[i] will store the largest number string that sums up to i.
    // It's an array of char pointers, each pointing to a dynamically allocated string.
    char** dp = (char**)malloc((target + 1) * sizeof(char*));
    if (dp == NULL) {
        // Handle allocation failure for the dp array
        return strdup("0");
    }

    // Initialize dp table
    // dp[0] is an empty string, representing the base case for a sum of 0.
    dp[0] = strdup("");
    if (dp[0] == NULL) {
        // Handle allocation failure for dp[0]
        free(dp);
        return strdup("0");
    }

    // For sums > 0, initialize with "0".
    // "0" serves two purposes:
    // 1. It indicates that the current sum is unreachable.
    // 2. It is the required return value if no solution is found for 'target'.
    for (int i = 1; i <= target; ++i) {
        dp[i] = strdup("0");
        if (dp[i] == NULL) {
            // Handle allocation failure and clean up previously allocated strings
            for (int j = 0; j < i; ++j) {
                free(dp[j]);
            }
            free(dp);
            return strdup("0");
        }
    }

    // Iterate through all possible target sums from 1 up to 'target'.
    for (int t = 1; t <= target; ++t) {
        // Iterate through digits from 9 down to 1.
        // This order is crucial for forming the lexicographically largest number:
        // - When two paths result in strings of the same length, preferring a larger digit
        //   at the current position ensures the resulting number is lexicographically larger.
        // - cost[d-1] corresponds to the cost of using digit 'd'.
        for (int d = 9; d >= 1; --d) {
            int current_cost = cost[d - 1]; // Get the cost for the current digit 'd'

            // Check if the current sum 't' can be reached by adding digit 'd'.
            // This requires:
            // 1. 't' must be at least 'current_cost'.
            // 2. The previous state (t - current_cost) must have been reachable (i.e., its string is not "0").
            if (t >= current_cost) {
                char* prev_str = dp[t - current_cost];

                // If the previous state was unreachable, we cannot form a number using this digit.
                if (strcmp(prev_str, "0") == 0) {
                    continue;
                }

                // Construct a candidate string by appending digit 'd' to the string from the previous state.
                // Max length of prev_str can be 'target' (e.g., if all costs are 1).
                // We need space for strlen(prev_str) + 1 (for the new digit) + 1 (for the null terminator).
                char* candidate = (char*)malloc(strlen(prev_str) + 2);
                if (candidate == NULL) {
                    // Handle allocation failure and clean up all allocated strings
                    for (int j = 0; j <= target; ++j) {
                        free(dp[j]);
                    }
                    free(dp);
                    return strdup("0");
                }
                strcpy(candidate, prev_str); // Copy the previous string
                candidate[strlen(prev_str)] = (char)(d + '0'); // Append the digit character
                candidate[strlen(prev_str) + 1] = '\0';        // Null-terminate the new string

                // Compare the newly formed candidate string with the current best string stored in dp[t].
                // If candidate represents a larger number, update dp[t].
                if (compare_num_strings(candidate, dp[t]) > 0) {
                    free(dp[t]);   // Free the old string at dp[t] to prevent memory leak
                    dp[t] = candidate; // Update dp[t] with the new, better string
                } else {
                    free(candidate); // Candidate was not better, free it to prevent memory leak
                }
            }
        }
    }

    // The final result is the string stored in dp[target].
    char* result = dp[target];

    // Clean up all other dynamically allocated strings in the dp table,
    // except for dp[target] which is being returned.
    for (int i = 0; i <= target; ++i) {
        if (i != target) {
            free(dp[i]);
        }
    }
    free(dp); // Free the dp array itself

    // The caller is responsible for freeing the 'result' string.
    return result;
}