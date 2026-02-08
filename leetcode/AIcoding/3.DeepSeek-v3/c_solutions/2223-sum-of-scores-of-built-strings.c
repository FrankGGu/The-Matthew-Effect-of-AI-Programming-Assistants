#include <string.h>
#include <stdlib.h>

long long sumScores(char* s) {
    int n = strlen(s);
    int* z = (int*)calloc(n, sizeof(int));
    int l = 0, r = 0;

    for (int i = 1; i < n; i++) {
        if (i <= r) {
            z[i] = (r - i + 1) < z[i - l] ? (r - i + 1) : z[i - l];
        }
        while (i + z[i] < n && s[z[i]] == s[i + z[i]]) {
            z[i]++;
        }
        if (i + z[i] - 1 > r) {
            l = i;
            r = i + z[i] - 1;
        }
    }

    long long sum = n;
    for (int i = 1; i < n; i++) {
        sum += z[i];
    }

    free(z);
    return sum;
}