#include <stdbool.h>
#include <string.h>
#include <stdlib.h> // For max

int max(int a, int b) {
    return a > b ? a : b;
}

bool canBeValid(char * s, char * locked){
    int n = strlen(s);

    // A valid parentheses string must have an even length.
    if (n % 2 != 0) {
        return false;
    }

    // open_min tracks the minimum possible balance of open parentheses.
    // open_max tracks the maximum possible balance of open parentheses.
    int open_min = 0;
    int open_max = 0;

    for (int i = 0; i < n; i++) {
        if (locked[i] == '1') { // Character is fixed
            if (s[i] == '(') {
                open_min++;
                open_max++;
            } else { // s[i] == ')'
                open_min--;
                open_max--;
            }
        } else { // locked[i] == '0', character can be changed
            // To get the minimum possible balance, assume it's a ')'
            open_min--;
            // To get the maximum possible balance, assume it's a '('
            open_max++;
        }

        // The balance cannot go below 0 for any valid prefix.
        // If open_min becomes negative, it means even if we try to close as much as possible,
        // we still have a negative balance, which is invalid.
        // So, we reset open_min to 0 if it drops below, effectively saying we must use
        // some '0's as '(' to maintain non-negative balance.
        open_min = max(0, open_min);

        // If open_max becomes negative, it means even if we use all flexible characters as '(',
        // the balance is still negative. This implies too many ')' that cannot be matched.
        if (open_max < 0) {
            return false;
        }
    }

    // For the entire string to be valid, the final balance must be exactly 0.
    // If open_min is 0 at the end, it means it's possible to achieve a final balance of 0
    // while satisfying the non-negative prefix balance condition.
    return open_min == 0;
}