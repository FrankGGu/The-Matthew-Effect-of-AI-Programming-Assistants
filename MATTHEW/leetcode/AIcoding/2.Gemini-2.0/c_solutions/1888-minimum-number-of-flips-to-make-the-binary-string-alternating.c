#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minFlips(char* s) {
    int n = strlen(s);
    char* doubled_s = (char*)malloc((2 * n + 1) * sizeof(char));
    strcpy(doubled_s, s);
    strcat(doubled_s, s);

    char* s1 = (char*)malloc((2 * n + 1) * sizeof(char));
    char* s2 = (char*)malloc((2 * n + 1) * sizeof(char));

    for (int i = 0; i < 2 * n; i++) {
        s1[i] = (i % 2 == 0) ? '0' : '1';
        s2[i] = (i % 2 == 0) ? '1' : '0';
    }
    s1[2 * n] = '\0';
    s2[2 * n] = '\0';

    int diff1 = 0;
    int diff2 = 0;
    int min_flips = n;

    for (int i = 0; i < n; i++) {
        if (doubled_s[i] != s1[i]) diff1++;
        if (doubled_s[i] != s2[i]) diff2++;
    }

    min_flips = (diff1 < diff2) ? diff1 : diff2;

    for (int i = n; i < 2 * n; i++) {
        if (doubled_s[i - n] != s1[i - n]) diff1--;
        if (doubled_s[i - n] != s2[i - n]) diff2--;

        if (doubled_s[i] != s1[i]) diff1++;
        if (doubled_s[i] != s2[i]) diff2++;

        min_flips = (min_flips < diff1) ? min_flips : diff1;
        min_flips = (min_flips < diff2) ? min_flips : diff2;
    }

    free(doubled_s);
    free(s1);
    free(s2);

    return min_flips;
}