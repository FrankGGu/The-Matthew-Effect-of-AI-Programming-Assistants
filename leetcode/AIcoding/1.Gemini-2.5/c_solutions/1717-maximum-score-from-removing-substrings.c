#include <string.h>
#include <stdlib.h>

int removeAndScore(char* s, char char1, char char2, int points) {
    int score = 0;
    int write_idx = 0;
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        s[write_idx] = s[i];
        write_idx++;

        if (write_idx >= 2 && s[write_idx - 2] == char1 && s[write_idx - 1] == char2) {
            write_idx -= 2;
            score += points;
        }
    }
    s[write_idx] = '\0';
    return score;
}

int maximumGain(char* s, int x, int y) {
    int total_score = 0;

    char* current_s = strdup(s);
    if (current_s == NULL) {
        return 0;
    }

    if (x >= y) {
        total_score += removeAndScore(current_s, 'a', 'b', x);
        total_score += removeAndScore(current_s, 'b', 'a', y);
    } else {
        total_score += removeAndScore(current_s, 'b', 'a', y);
        total_score += removeAndScore(current_s, 'a', 'b', x);
    }

    free(current_s);
    return total_score;
}