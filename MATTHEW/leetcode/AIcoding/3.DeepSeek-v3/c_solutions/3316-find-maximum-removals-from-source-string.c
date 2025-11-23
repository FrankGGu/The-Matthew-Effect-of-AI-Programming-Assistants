#include <string.h>

int maximumRemovals(char* s, char* p, int* removable, int removableSize) {
    int slen = strlen(s);
    int plen = strlen(p);

    int left = 0, right = removableSize;

    while (left <= right) {
        int mid = left + (right - left) / 2;

        char temp[slen + 1];
        strcpy(temp, s);

        for (int i = 0; i < mid; i++) {
            temp[removable[i]] = '*';
        }

        int i = 0, j = 0;
        while (i < slen && j < plen) {
            if (temp[i] == p[j]) {
                j++;
            }
            i++;
        }

        if (j == plen) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return right;
}