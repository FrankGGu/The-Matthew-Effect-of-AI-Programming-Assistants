#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSwapStrings(char* s1, char* s2) {
    int count1 = 0, count2 = 0;
    for (int i = 0; s1[i] != '\0'; i++) {
        if (s1[i] != s2[i]) {
            if (s1[i] == 'a') count1++;
            else count2++;
        }
    }
    return (count1 + 1) / 2 + (count2 + 1) / 2;
}