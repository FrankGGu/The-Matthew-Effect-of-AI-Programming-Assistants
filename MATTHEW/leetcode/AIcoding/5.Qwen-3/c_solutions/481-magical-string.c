#include <stdio.h>
#include <stdlib.h>

int magicalString(int n) {
    if (n == 0) return 0;
    if (n <= 3) return 1;

    int* s = (int*)malloc((n + 1) * sizeof(int));
    s[0] = 1;
    s[1] = 1;
    s[2] = 2;
    int i = 2, j = 2;
    while (j < n) {
        int next = s[i];
        int val = s[j - 1] == 1 ? 2 : 1;
        for (int k = 0; k < next && j < n; k++) {
            s[j++] = val;
        }
        i++;
    }

    int count = 0;
    for (int k = 0; k < n; k++) {
        if (s[k] == 1) count++;
    }

    free(s);
    return count;
}