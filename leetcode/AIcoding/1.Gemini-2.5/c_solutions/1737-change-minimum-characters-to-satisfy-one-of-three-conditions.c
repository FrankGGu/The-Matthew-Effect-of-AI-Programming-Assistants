#include <string.h>

#define MIN(a, b) ((a) < (b) ? (a) : (b))

int minCharacters(char * a, char * b){
    int m = strlen(a);
    int n = strlen(b);

    int freqA[26] = {0};
    int freqB[26] = {0};

    for (int i = 0; i < m; ++i) {
        freqA[a[i] - 'a']++;
    }
    for (int i = 0; i < n; ++i) {
        freqB[b[i] - 'a']++;
    }

    int min_total_changes = m + n;

    // Condition 1: Every character in 'a' is strictly less than every character in 'b'.
    // This means there exists a character 'x' (from 'a' to 'y') such that:
    // all chars in 'a' are <= 'x'
    // all chars in 'b' are > 'x'
    for (int k = 0; k < 25; ++k) { // k represents 'x' (0 for 'a', 24 for 'y')
        int current_changes = 0;
        // Count chars in 'a' that are > 'x'
        for (int i = k + 1; i < 26; ++i) {
            current_changes += freqA[i];
        }
        // Count chars in 'b' that are <= 'x'
        for (int i = 0; i <= k; ++i) {
            current_changes += freqB[i];
        }
        min_total_changes = MIN(min_total_changes, current_changes);
    }

    // Condition 2: Every character in 'b' is strictly less than every character in 'a'.
    // This is symmetric to Condition 1.
    // There exists a character 'x' (from 'a' to 'y') such that:
    // all chars in 'b' are <= 'x'
    // all chars in 'a' are > 'x'
    for (int k = 0; k < 25; ++k) { // k represents 'x' (0 for 'a', 24 for 'y')
        int current_changes = 0;
        // Count chars in 'b' that are > 'x'
        for (int i = k + 1; i < 26; ++i) {
            current_changes += freqB[i];
        }
        // Count chars in 'a' that are <= 'x'
        for (int i = 0; i <= k; ++i) {
            current_changes += freqA[i];
        }
        min_total_changes = MIN(min_total_changes, current_changes);
    }

    // Condition 3: Every character in 'a' and every character in 'b' are the same character.
    // This means all characters in 'a' become 'x' and all characters in 'b' become 'x'.
    for (int k = 0; k < 26; ++k) { // k represents 'x' (0 for 'a', 25 for 'z')
        int current_changes = (m - freqA[k]) + (n - freqB[k]);
        min_total_changes = MIN(min_total_changes, current_changes);
    }

    return min_total_changes;
}