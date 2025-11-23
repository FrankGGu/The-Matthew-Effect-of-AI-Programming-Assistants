#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countRepetitions(char* s, int* m, char* b, int* n, int len) {
    int i, j;
    int count = 0;
    int total = 0;
    int* repeat = (int*)malloc(sizeof(int) * len);
    int* index = (int*)malloc(sizeof(int) * len);
    int k = 0;
    for (i = 0; i < len; i++) {
        repeat[i] = 0;
        index[i] = 0;
    }
    for (i = 0; i < len; i++) {
        int pos = 0;
        int cnt = 0;
        while (pos < strlen(s)) {
            if (s[pos] == b[0]) {
                int match = 1;
                for (j = 1; j < *n; j++) {
                    if (pos + j >= strlen(s) || s[pos + j] != b[j]) {
                        match = 0;
                        break;
                    }
                }
                if (match) {
                    cnt++;
                    pos += *n;
                } else {
                    pos++;
                }
            } else {
                pos++;
            }
        }
        repeat[k] = cnt;
        index[k++] = i;
    }
    for (i = 0; i < len; i++) {
        total += repeat[i];
    }
    free(repeat);
    free(index);
    return total;
}