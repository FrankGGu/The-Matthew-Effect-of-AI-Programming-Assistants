#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isSubsequence(const char* s, const char* t) {
    int i = 0, j = 0;
    while (s[i] && t[j]) {
        if (s[i] == t[j]) {
            i++;
        }
        j++;
    }
    return s[i] == '\0';
}

int maximumRemovals(char * s, char * p, int* removable, int removableSize){
    int left = 0, right = removableSize - 1;
    int ans = 0;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        char temp[strlen(s) + 1];
        strcpy(temp, s);
        for (int i = 0; i <= mid; i++) {
            temp[removable[i]] = '#';
        }
        char filtered[strlen(s) + 1];
        int k = 0;
        for (int i = 0; i < strlen(s); i++) {
            if (temp[i] != '#') {
                filtered[k++] = temp[i];
            }
        }
        filtered[k] = '\0';
        if (isSubsequence(p, filtered)) {
            ans = mid + 1;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return ans;
}