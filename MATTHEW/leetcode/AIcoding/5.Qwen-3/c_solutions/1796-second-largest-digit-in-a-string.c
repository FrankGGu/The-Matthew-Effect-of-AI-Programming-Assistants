#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

int secondLargest(char *s) {
    int max1 = -1, max2 = -1;
    for (int i = 0; s[i]; i++) {
        if (isdigit(s[i])) {
            int num = s[i] - '0';
            if (num > max1) {
                max2 = max1;
                max1 = num;
            } else if (num < max1 && num > max2) {
                max2 = num;
            }
        }
    }
    return max2;
}