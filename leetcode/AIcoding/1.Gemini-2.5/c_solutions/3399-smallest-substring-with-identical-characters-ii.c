#include <string.h>
#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int smallestSubstringWithIdenticalCharacters(char* s) {
    int max_runs[26];
    _Bool char_present[26];

    for (int i = 0; i < 26; ++i) {
        max_runs[i] = 0;
        char_present[i] = 0;
    }

    int n = strlen(s);

    int current_run = 0;
    char current_char = '\0';

    for (int i = 0; i < n; ++i) {
        char_present[s[i] - 'a'] = 1;

        if (s[i] == current_char) {
            current_run++;
        } else {
            if (current_char != '\0') {
                max_runs[current_char - 'a'] = max(max_runs[current_char - 'a'], current_run);
            }
            current_char = s[i];
            current_run = 1;
        }
    }

    if (current_char != '\0') {
        max_runs[current_char - 'a'] = max(max_runs[current_char - 'a'], current_run);
    }

    int min_overall_max_run = INT_MAX;

    for (int i = 0; i < 26; ++i) {
        if (char_present[i]) {
            min_overall_max_run = min(min_overall_max_run, max_runs[i]);
        }
    }

    return min_overall_max_run;
}