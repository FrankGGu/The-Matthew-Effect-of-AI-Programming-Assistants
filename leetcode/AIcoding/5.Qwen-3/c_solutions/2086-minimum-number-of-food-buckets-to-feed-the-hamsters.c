#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumBuckets(char *street) {
    int n = strlen(street);
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (street[i] == 'H') {
            if (i + 1 < n && street[i + 1] == 'H') {
                count++;
                i += 2;
            } else if (i - 1 >= 0 && street[i - 1] == 'H') {
                continue;
            } else {
                count++;
                i++;
            }
        }
    }
    return count;
}