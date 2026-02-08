#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumBuckets(char * street){
    int n = strlen(street);
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (street[i] == 'H') {
            if (i > 0 && street[i - 1] == 'B') {
                continue;
            } else if (i < n - 1 && street[i + 1] == '.') {
                street[i + 1] = 'B';
                count++;
            } else if (i > 0 && street[i - 1] == '.') {
                count++;
            } else {
                return -1;
            }
        }
    }
    return count;
}