#include <stdlib.h>
#include <string.h>

char *shiftingLetters(char *s, int **shifts, int shiftsSize, int *shiftsColSize) {
    int n = strlen(s);

    int *diff = (int *)calloc(n + 1, sizeof(int));

    for (int i = 0; i < shiftsSize; i++) {
        int start = shifts[i][0];
        int end = shifts[i][1];
        int direction = shifts[i][2];

        if (direction == 1) {
            diff[start]++;
            if (end + 1 < n + 1) {
                diff[end + 1]--;
            }
        } else {
            diff[start]--;
            if (end + 1 < n + 1) {
                diff[end + 1]++;
            }
        }
    }

    long long current_shift = 0;
    for (int i = 0; i < n; i++) {
        current_shift += diff[i];

        int effective_shift = (int)(current_shift % 26 + 26) % 26;

        s[i] = 'a' + (s[i] - 'a' + effective_shift) % 26;
    }

    free(diff);

    return s;
}