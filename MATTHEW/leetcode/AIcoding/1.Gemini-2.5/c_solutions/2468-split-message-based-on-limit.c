#include <stdlib.h> // For malloc, free
#include <string.h> // For strlen, strncpy
#include <stdio.h>  // For sprintf
#include <stdbool.h> // For bool

int get_num_digits(int n) {
    if (n == 0) return 1;
    int count = 0;
    while (n > 0) {
        n /= 10;
        count++;
    }
    return count;
}

long long get_sum_digits_up_to_N(int N) {
    if (N == 0) return 0;
    long long res = 0;
    long long power_of_10 = 1; // Represents 1, 10, 100, ...
    int num_digits_val = 1;    // Represents 1, 2, 3, ... (number of digits)

    // Sum digits for numbers with `num_digits_val` digits
    // e.g., for num_digits_val=1 (1-9), num_digits_val=2 (10-99), etc.
    while (power_of_10 * 10 <= N) {
        res += (long long)num_digits_val * 9 * power_of_10;
        power_of_10 *= 10;
        num_digits_val++;
    }
    // Add digits for the remaining numbers (from power_of_10 to N)
    res += (long long)num_digits_val * (N - power_of_10 + 1);
    return res;
}

bool check(int y, int message_len, int limit) {
    if (y == 0) return false; // Number of parts must be at least 1
    int len_y = get_num_digits(y);

    // The length of the suffix for any part 'x' is 4 + num_digits(x) + len_y.
    // The available text length for a part 'x' is limit - (4 + num_digits(x) + len_y).
    // For the first part (x=1), num_digits(x) = 1.
    // If limit - (4 + 1 + len_y) is less than 1, then no part can hold even 1 character.
    // Since message_len >= 1, this 'y' is invalid.
    if (limit - (4 + 1 + len_y) < 1) {
        return false;
    }

    // Total characters that can be stored across 'y' parts is:
    // sum_{x=1 to y} (limit - (4 + num_digits(x) + len_y))
    // = sum_{x=1 to y} (limit - 4 - len_y) - sum_{x=1 to y} num_digits(x)
    // = y * (limit - 4 - len_y) - get_sum_digits_up_to_N(y)
    long long total_text_chars_possible = (long long)y * (limit - 4 - len_y) - get_sum_digits_up_to_N(y);

    return total_text_chars_possible >= message_len;
}

char** splitMessage(char* message, int limit, int* returnSize) {
    int message_len = strlen(message);

    int final_y = -1;
    // Binary search for the minimum total number of parts 'y'.
    // 'y' can range from 1 to message_len (if each part holds 1 char).
    // A safe upper bound for y is message_len + a small buffer (e.g., 100-200)
    // Max message_len is 10^5, so 100200 is a safe upper bound.
    int low = 1, high = message_len + 200; 

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (check(mid, message_len, limit)) {
            final_y = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    // According to problem constraints, a solution is always guaranteed.
    // So final_y will hold the optimal number of parts.

    char** ans = (char**)malloc(final_y * sizeof(char*));
    int current_message_idx = 0;
    int len_y_final = get_num_digits(final_y);

    for (int i = 0; i < final_y; i++) {
        int part_num = i + 1;
        int len_x_current = get_num_digits(part_num);

        int current_suffix_len = 4 + len_x_current + len_y_final; // e.g., "(1/1)" -> 4 + 1 + 1 = 6
        int current_text_len = limit - current_suffix_len;

        // current_text_len should be non-negative due to the check() function.
        // However, ensure it doesn't go below 0 just in case.
        if (current_text_len < 0) current_text_len = 0; 

        int chars_to_copy = current_text_len;
        if (message_len - current_message_idx < chars_to_copy) {
            chars_to_copy = message_len - current_message_idx;
        }

        // Allocate memory for the current part string.
        // It will hold 'chars_to_copy' characters + the suffix + null terminator.
        // The total length of a part is `chars_to_copy + current_suffix_len`.
        // If `chars_to_copy` is `current_text_len`, then total length is `current_text_len + current_suffix_len = limit`.
        ans[i] = (char*)malloc((chars_to_copy + current_suffix_len + 1) * sizeof(char));

        strncpy(ans[i], message + current_message_idx, chars_to_copy);
        ans[i][chars_to_copy] = '\0'; // Null-terminate the copied text
        current_message_idx += chars_to_copy;

        sprintf(ans[i] + chars_to_copy, "(%d/%d)", part_num, final_y);
    }

    *returnSize = final_y;
    return ans;
}