#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countCollisions(char* s) {
    int n = strlen(s);
    int count = 0;
    int i = 0;

    while (i < n && s[i] == 'L') {
        i++;
    }

    for (; i < n; i++) {
        if (s[i] == 'S') {
            count++;
            while (i + 1 < n && s[i + 1] == 'L') {
                i++;
                count++;
            }
        } else if (s[i] == 'R') {
            while (i + 1 < n && s[i + 1] == 'R') {
                i++;
            }
            while (i + 1 < n && s[i + 1] == 'L') {
                i++;
                count++;
            }
        }
    }

    return count;
}