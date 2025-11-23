#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(char* str) {
    int even[26] = {0}, odd[26] = {0};
    for (int i = 0; str[i]; i++) {
        if (i % 2 == 0) even[str[i] - 'a']++;
        else odd[str[i] - 'a']++;
    }
    char key[52];
    int index = 0;
    for (int i = 0; i < 26; i++) {
        if (even[i]) {
            index += sprintf(key + index, "%d%c", even[i], 'a' + i);
        }
        if (odd[i]) {
            index += sprintf(key + index, "%d%c", odd[i], 'a' + i);
        }
    }
    return hash(key);
}

int hash(char* str) {
    unsigned long long hash = 0;
    for (int i = 0; str[i]; i++) {
        hash = hash * 31 + str[i];
    }
    return hash % 1009;
}

int numSpecialEquivGroups(char ** A, int ASize) {
    int *seen = (int *)calloc(1009, sizeof(int));
    int count = 0;
    for (int i = 0; i < ASize; i++) {
        int idx = find(A[i]);
        if (!seen[idx]) {
            seen[idx] = 1;
            count++;
        }
    }
    free(seen);
    return count;
}