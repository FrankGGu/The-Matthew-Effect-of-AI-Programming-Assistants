#include <stdlib.h>
#include <string.h>

char *getSmallestString(int n, int k) {
    char *result = (char *)malloc((n + 1) * sizeof(char));
    if (result == NULL) {
        return NULL;
    }
    result[n] = '\0';

    for (int i = 0; i < n; i++) {
        result[i] = 'a';
    }

    k -= n;

    for (int i = n - 1; i >= 0 && k > 0; i--) {
        int add = k;
        if (add > 25) {
            add = 25;
        }
        result[i] += add;
        k -= add;
    }

    return result;
}