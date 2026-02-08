#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int strStr(char * haystack, char * needle){
    int n = strlen(haystack);
    int m = strlen(needle);

    if (m == 0) return 0;
    if (n < m) return -1;

    for (int i = 0; i <= n - m; i++) {
        int diff = 0;
        for (int j = 0; j < m; j++) {
            if (haystack[i + j] != needle[j]) {
                diff++;
            }
        }
        if (diff <= 1) {
            return i;
        }
    }

    return -1;
}