#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isSubsequence(const char *s, const char *p, const int *removable, int remSize) {
    int i = 0, j = 0, k = 0;
    bool removed[strlen(s)];
    memset(removed, false, sizeof(removed));

    for (int l = 0; l < remSize; l++) {
        removed[removable[l]] = true;
    }

    while (i < strlen(s) && j < strlen(p)) {
        if (i < strlen(s) && removed[i]) {
            i++;
            continue;
        }

        if (s[i] == p[j]) {
            i++;
            j++;
        } else {
            i++;
        }
    }

    return j == strlen(p);
}

int maximumRemovals(char * s, char * p, int* removable, int removableSize){
    int left = 0, right = removableSize;
    int ans = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;

        if (isSubsequence(s, p, removable, mid)) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
}