#include <string.h>
#include <stdbool.h>

bool canTransform(char* start, char* end) {
    int n = strlen(start);
    int m = strlen(end);

    if (n != m) {
        return false;
    }

    int i = 0; // pointer for start string
    int j = 0; // pointer for end string

    while (i < n && j < n) {
        // Skip 'X' characters in the start string
        while (i < n && start[i] == 'X') {
            i++;
        }
        // Skip 'X' characters in the end string
        while (j < n && end[j] == 'X') {
            j++;
        }

        // If both pointers reached the end, or one did while the other didn't (handled by final check)
        if (i == n || j == n) {
            break;
        }

        // If the non-'X' characters don't match, transformation is impossible
        if (start[i] != end[j]) {
            return false;
        }

        // Check movement constraints
        if (start[i] == 'L') {
            // 'L' can only move left. Its original position (i) must be greater than or equal to its final position (j).
            if (i < j) {
                return false;
            }
        } else { // start[i] == 'R'
            // 'R' can only move right. Its original position (i) must be less than or equal to its final position (j).
            if (i > j) {
                return false;
            }
        }

        // Move to the next non-'X' character pair
        i++;
        j++;
    }

    // After the loop, ensure both pointers have reached the end of their respective strings
    // (i.e., all characters, including trailing 'X's, have been processed).
    while (i < n && start[i] == 'X') {
        i++;
    }
    while (j < n && end[j] == 'X') {
        j++;
    }

    return i == n && j == n;
}