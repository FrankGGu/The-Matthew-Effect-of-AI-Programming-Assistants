#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubstrings(char * s, char * t){
    int n = strlen(s);
    int m = strlen(t);
    int count = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            int diff = 0;
            for (int k = 0; i + k < n && j + k < m; k++) {
                if (s[i + k] != t[j + k]) {
                    diff++;
                }
                if (diff == 1) {
                    count++;
                } else if (diff > 1) {
                    break;
                }
            }
        }
    }

    return count;
}