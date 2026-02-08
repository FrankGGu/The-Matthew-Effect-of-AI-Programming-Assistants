#include <stdlib.h>
#include <string.h>

int* diStringMatch(char *s, int* returnSize) {
    int n = strlen(s);
    *returnSize = n + 1;
    int* perm = (int*) malloc(sizeof(int) * (n + 1));

    int low = 0;
    int high = n;

    for (int i = 0; i < n; i++) {
        if (s[i] == 'I') {
            perm[i] = low;
            low++;
        } else {
            perm[i] = high;
            high--;
        }
    }

    perm[n] = low;

    return perm;
}