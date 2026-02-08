#include <stdbool.h>
#include <string.h>

bool checkDistances(char * s, int* distance, int distanceSize) {
    int first_occurrence[26];
    for (int i = 0; i < 26; i++) {
        first_occurrence[i] = -1;
    }

    int n = strlen(s);
    for (int k = 0; k < n; k++) {
        int char_idx = s[k] - 'a';
        if (first_occurrence[char_idx] == -1) {
            first_occurrence[char_idx] = k;
        } else {
            int actual_dist = k - first_occurrence[char_idx] - 1;
            if (actual_dist != distance[char_idx]) {
                return false;
            }
        }
    }

    return true;
}