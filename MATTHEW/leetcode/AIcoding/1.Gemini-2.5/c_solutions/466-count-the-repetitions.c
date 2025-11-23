#include <string.h> // For strlen

int getMaxRepetitions(char * s1, int n1, char * s2, int n2){
    int s1_len = strlen(s1);
    int s2_len = strlen(s2);

    if (s1_len == 0 || s2_len == 0 || n1 == 0 || n2 == 0) {
        return 0;
    }

    // s1_counts_at_s2_ptr[i] stores the current_s1_reps when s2_ptr 'i' was first encountered.
    // s2_counts_at_s2_ptr[i] stores the current_s2_reps when s2_ptr 'i' was first encountered.
    // Initialize with -1 to indicate not visited.
    int s1_counts_at_s2_ptr[s2_len];
    int s2_counts_at_s2_ptr[s2_len];
    for (int i = 0; i < s2_len; ++i) {
        s1_counts_at_s2_ptr[i] = -1;
        s2_counts_at_s2_ptr[i] = -1;
    }

    int current_s1_reps = 0; // Number of s1 blocks processed
    long long current_s2_reps = 0; // Number of s2 blocks formed (can be very large)
    int s2_ptr = 0; // Current index in s2

    // Loop through s1 repetitions
    while (current_s1_reps < n1) {
        // Check for cycle detection
        if (s1_counts_at_s2_ptr[s2_ptr] != -1) {
            int prev_s1_reps = s1_counts_at_s2_ptr[s2_ptr];
            int prev_s2_reps = s2_counts_at_s2_ptr[s2_ptr];

            int s1_cycle_len = current_s1_reps - prev_s1_reps;
            long long s2_cycle_len = current_s2_reps - prev_s2_reps;

            long long remaining_s1_reps = (long long)n1 - current_s1_reps;
            long long num_cycles = remaining_s1_reps / s1_cycle_len;

            current_s2_reps += num_cycles * s2_cycle_len;
            current_s1_reps += num_cycles * s1_cycle_len;

            // Break from cycle detection loop, remaining s1 blocks will be processed linearly
            break;
        } else {
            // Store current state for s2_ptr if first time encountered
            s1_counts_at_s2_ptr[s2_ptr] = current_s1_reps;
            s2_counts_at_s2_ptr[s2_ptr] = (int)current_s2_reps; // current_s2_reps won't exceed int max before cycle detection
        }

        // Match one s1 block against s2
        for (int i = 0; i < s1_len; ++i) {
            if (s1[i] == s2[s2_ptr]) {
                s2_ptr++;
                if (s2_ptr == s2_len) {
                    s2_ptr = 0;
                    current_s2_reps++;
                }
            }
        }
        current_s1_reps++; // One s1 block consumed
    }

    // Process any remaining s1 blocks (either after cycle extrapolation, or if n1 was small enough
    // that no cycle was detected before current_s1_reps reached n1)
    while (current_s1_reps < n1) {
        for (int i = 0; i < s1_len; ++i) {
            if (s1[i] == s2[s2_ptr]) {
                s2_ptr++;
                if (s2_ptr == s2_len) {
                    s2_ptr = 0;
                    current_s2_reps++;
                }
            }
        }
        current_s1_reps++;
    }

    return (int)(current_s2_reps / n2);
}