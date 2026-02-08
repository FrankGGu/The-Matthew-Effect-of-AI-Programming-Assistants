#include <string.h>
#include <stdlib.h>
#include <limits.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int minFlips(char * s){
    int n = strlen(s);

    if (n == 1) {
        return 0;
    }

    char *s_double = (char *)malloc(sizeof(char) * (2 * n + 1));
    if (s_double == NULL) {
        return -1;
    }
    strcpy(s_double, s);
    strcat(s_double, s);

    int *pref1 = (int *)calloc(2 * n + 1, sizeof(int));
    int *pref2 = (int *)calloc(2 * n + 1, sizeof(int));
    if (pref1 == NULL || pref2 == NULL) {
        free(s_double);
        free(pref1);
        free(pref2);
        return -1;
    }

    for (int k = 0; k < 2 * n; ++k) {
        pref1[k+1] = pref1[k];
        pref2[k+1] = pref2[k];

        char target1_char = (k % 2 == 0) ? '0' : '1';
        if (s_double[k] != target1_char) {
            pref1[k+1]++;
        }

        char target2_char = (k % 2 == 0) ? '1' : '0';
        if (s_double[k] != target2_char) {
            pref2[k+1]++;
        }
    }

    int min_flips_total = INT_MAX;

    for (int i = 0; i < n; ++i) {
        int current_flips_to_0101;
        int current_flips_to_1010;

        if (i % 2 == 0) {
            current_flips_to_0101 = pref1[i+n] - pref1[i];
            current_flips_to_1010 = pref2[i+n] - pref2[i];
        } else {
            current_flips_to_0101 = pref2[i+n] - pref2[i];
            current_flips_to_1010 = pref1[i+n] - pref1[i];
        }

        min_flips_total = min(min_flips_total, current_flips_to_0101);
        min_flips_total = min(min_flips_total, current_flips_to_1010);
    }

    free(s_double);
    free(pref1);
    free(pref2);

    return min_flips_total;
}