#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int partitionString(char *s) {
    int count = 1;
    int seen[26] = {0};
    for (int i = 0; s[i]; i++) {
        int index = s[i] - 'a';
        if (seen[index]) {
            count++;
            memset(seen, 0, sizeof(seen));
        }
        seen[index] = 1;
    }
    return count;
}