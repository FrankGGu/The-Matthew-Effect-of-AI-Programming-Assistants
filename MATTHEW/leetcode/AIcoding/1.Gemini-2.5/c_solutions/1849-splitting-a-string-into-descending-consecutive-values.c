#include <stdbool.h>
#include <string.h>
#include <limits.h>

bool backtrack(char *s, int start_idx, long long prev_val, int num_splits) {
    if (s[start_idx] == '\0') {
        return num_splits >= 2;
    }

    long long current_val = 0;
    for (int i = start_idx; s[i] != '\0'; i++) {
        int digit = s[i] - '0';

        if (current_val > (LLONG_MAX - digit) / 10) {
            break; 
        }

        current_val = current_val * 10 + digit;

        if (num_splits == 0) {
            if (backtrack(s, i + 1, current_val, num_splits + 1)) {
                return true;
            }
        } else {
            if (current_val == prev_val - 1) {
                if (backtrack(s, i + 1, current_val, num_splits + 1)) {
                    return true;
                }
            } else if (current_val > prev_val - 1) {
                break;
            }
        }
    }

    return false;
}

bool splitString(char * s) {
    return backtrack(s, 0, -1, 0);
}