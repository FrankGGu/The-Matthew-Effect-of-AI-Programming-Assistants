#include <string.h>
#include <stdlib.h>

int countBinarySubstrings(char * s){
    int n = strlen(s);
    if (n == 0) {
        return 0;
    }

    int *groups = (int *)malloc(sizeof(int) * n);
    if (groups == NULL) {
        return 0; // Handle memory allocation failure
    }

    int groupCount = 0;
    groups[groupCount] = 1;

    for (int i = 1; i < n; i++) {
        if (s[i] == s[i-1]) {
            groups[groupCount]++;
        } else {
            groupCount++;
            groups[groupCount] = 1;
        }
    }

    int totalCount = 0;
    for (int i = 0; i < groupCount; i++) {
        totalCount += (groups[i] < groups[i+1]) ? groups[i] : groups[i+1];
    }

    free(groups);
    return totalCount;
}