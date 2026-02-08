#include <string.h>
#include <limits.h>

int numberOfSpecialChars(char* s) {
    int first_occurrence_lower[26];
    int last_occurrence_upper[26];

    for (int i = 0; i < 26; i++) {
        first_occurrence_lower[i] = INT_MAX;
        last_occurrence_upper[i] = -1;
    }

    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        char c = s[i];
        if (c >= 'a' && c <= 'z') {
            int idx = c - 'a';
            if (i < first_occurrence_lower[idx]) {
                first_occurrence_lower[idx] = i;
            }
        } else if (c >= 'A' && c <= 'Z') {
            int idx = c - 'A';
            if (i > last_occurrence_upper[idx]) {
                last_occurrence_upper[idx] = i;
            }
        }
    }

    int special_chars_count = 0;
    for (int i = 0; i < 26; i++) {
        if (first_occurrence_lower[i] != INT_MAX && 
            last_occurrence_upper[i] != -1 &&
            first_occurrence_lower[i] < last_occurrence_upper[i]) {
            special_chars_count++;
        }
    }

    return special_chars_count;
}