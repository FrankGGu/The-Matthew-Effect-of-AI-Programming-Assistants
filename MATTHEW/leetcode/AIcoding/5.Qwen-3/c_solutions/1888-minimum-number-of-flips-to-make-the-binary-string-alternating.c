#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minFlipsAlternating(char* s) {
    int n = strlen(s);
    int count0 = 0, count1 = 0;
    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            if (s[i] != '0') count0++;
            if (s[i] != '1') count1++;
        } else {
            if (s[i] != '1') count0++;
            if (s[i] != '0') count1++;
        }
    }
    return (count0 < count1) ? count0 : count1;
}