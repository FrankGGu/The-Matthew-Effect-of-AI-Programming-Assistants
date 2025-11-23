#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSwapsToMakeBinaryStringAlternating(char* s) {
    int n = strlen(s);
    int count0 = 0, count1 = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == '0') count0++;
        else count1++;
    }

    if (abs(count0 - count1) > 1) return -1;

    int swap1 = 0, swap2 = 0;
    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            if (s[i] != '0') swap1++;
            if (s[i] != '1') swap2++;
        } else {
            if (s[i] != '1') swap1++;
            if (s[i] != '0') swap2++;
        }
    }

    if (count0 == count1) return (swap1 < swap2) ? swap1 : swap2;
    else if (count0 > count1) return swap1;
    else return swap2;
}