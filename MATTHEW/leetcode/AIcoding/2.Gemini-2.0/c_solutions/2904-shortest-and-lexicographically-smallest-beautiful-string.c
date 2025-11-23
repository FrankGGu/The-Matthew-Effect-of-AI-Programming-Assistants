#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * shortestBeautifulSubstring(char * s, int k){
    int n = strlen(s);
    int left = 0, right = 0;
    int count = 0;
    int start = -1, len = n + 1;
    char *res = NULL;

    while (right < n) {
        if (s[right] == '1') {
            count++;
        }

        while (count == k) {
            if (right - left + 1 < len) {
                len = right - left + 1;
                start = left;
            } else if (right - left + 1 == len) {
                if (start == -1 || strncmp(s + left, s + start, len) < 0) {
                    start = left;
                }
            }

            if (s[left] == '1') {
                count--;
            }
            left++;
        }
        right++;
    }

    if (start != -1) {
        res = (char *)malloc(sizeof(char) * (len + 1));
        strncpy(res, s + start, len);
        res[len] = '\0';
    }

    return res;
}