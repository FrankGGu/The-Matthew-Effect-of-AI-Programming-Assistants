#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumRemovableCharacters(char* s, char* p, int* removable, int removableSize) {
    int lenS = strlen(s);
    int lenP = strlen(p);
    int* pos = (int*)malloc(lenP * sizeof(int));
    for (int i = 0; i < lenP; i++) {
        pos[i] = -1;
    }
    for (int i = 0; i < removableSize; i++) {
        if (pos[removable[i]] == -1) {
            pos[removable[i]] = i;
        }
    }
    int count = 0;
    int j = 0;
    for (int i = 0; i < lenS && j < lenP; i++) {
        if (s[i] == p[j]) {
            if (pos[i] == -1 || pos[i] > count) {
                count++;
                j++;
            }
        }
    }
    free(pos);
    return count;
}