#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* decodeAtIndex(char* s, int k) {
    int n = strlen(s);
    long size = 0;
    for (int i = 0; i < n; ++i) {
        if (s[i] >= '0' && s[i] <= '9') {
            size *= (s[i] - '0');
        } else {
            size++;
        }
    }

    for (int i = n - 1; i >= 0; --i) {
        if (s[i] >= '0' && s[i] <= '9') {
            size /= (s[i] - '0');
        } else {
            if (size == k || k == 0) {
                char* result = (char*)malloc(2 * sizeof(char));
                result[0] = s[i];
                result[1] = '\0';
                return result;
            }
            size--;
        }
    }

    char* result = (char*)malloc(2 * sizeof(char));
    result[0] = '\0';
    return result;
}