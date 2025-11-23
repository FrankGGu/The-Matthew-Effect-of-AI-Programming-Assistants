#include <string>
#include <vector>

class Solution {
public:
    bool canChange(std::string start, std::string target) {
        int n = start.length();
        int i = 0; // Pointer for start string
        int j = 0; // Pointer for target string

        while (i < n && j < n) {
            // Skip '_' characters in start string
            while (i < n && start[i] == '_') {
                i++;
            }
            // Skip '_' characters in target string
            while (j < n && target[j] == '_') {
                j++;
            }

            // If one pointer reached the end but the other didn't,
            // or if both reached the end, we'll handle outside the loop.
            if (i == n || j == n) {
                break;
            }

            // At this point, start[i] and target[j] are non-'_' characters.
            // They must be the same character.
            if (start[i] != target[j]) {
                return false;
            }

            // Check movement rules based on the character type
            if (start[i] == 'L') {
                // 'L' can only move to the left.
                // Its final position 'j' must be less than or equal to its initial position 'i'.
                if (j > i) {
                    return false;
                }
            } else { // start[i] == 'R'
                // 'R' can only move to the right.
                // Its final position 'j' must be greater than or equal to its initial position 'i'.
                if (j < i) {
                    return false;
                }
            }

            // Move to the next non-'_' character for both strings
            i++;
            j++;
        }

        // After the loop, one or both pointers might have reached 'n'.
        // We need to ensure that any remaining characters in either string are all '_'.
        while (i < n && start[i] == '_') {
            i++;
        }
        while (j < n && target[j] == '_') {
            j++;
        }

        // Both pointers must have reached the end of their respective strings,
        // implying all non-'_' characters were matched and moved correctly.
        return i == n && j == n;
    }
};