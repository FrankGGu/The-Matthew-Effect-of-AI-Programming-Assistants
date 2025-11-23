#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

bool check(char* s, int index, int current_sum, int target) {
    // If current_sum exceeds target, this path is invalid.
    if (current_sum > target) {
        return false;
    }

    // If we've processed all digits
    if (index == strlen(s)) {
        // If current_sum exactly matches target, it's a valid partition.
        return current_sum == target;
    }

    long long current_num = 0;
    // Iterate through all possible substrings starting from 'index'
    for (int i = index; i < strlen(s); i++) {
        current_num = current_num * 10 + (s[i] - '0');

        // Pruning: if adding the current segment 'current_num' to the accumulated 'current_sum'
        // already exceeds the 'target', then this path is invalid.
        // Any further extension of 'current_num' (by incrementing 'i') will only make 'current_num' larger,
        // so 'current_sum + current_num' will remain greater than 'target'.
        // Thus, we can stop exploring segments starting from 'index' here.
        if (current_sum + current_num > target) {
            break; 
        }

        // Recursively check the rest of the string with the updated sum
        if (check(s, i + 1, current_sum + current_num, target)) {
            return true;
        }
    }

    // No valid partition found from this point
    return false;
}

int punishmentNumber(int n) {
    int total_punishment_sum = 0;
    // Max square for n=1000 is 1000*1000 = 1,000,000 (7 digits).
    // A buffer of 10 characters is sufficient for the string representation + null terminator.
    char s_str[10]; 

    for (int x = 1; x <= n; x++) {
        long long square = (long long)x * x;
        sprintf(s_str, "%lld", square); // Convert square to string

        if (check(s_str, 0, 0, x)) {
            total_punishment_sum += x;
        }
    }

    return total_punishment_sum;
}