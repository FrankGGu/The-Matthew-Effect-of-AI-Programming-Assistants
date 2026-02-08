#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

bool areNumbersAscending(char* s) {
    int prev = -1;
    int current = 0;
    int i = 0;

    while (s[i] != '\0') {
        if (isdigit(s[i])) {
            current = 0;
            while (s[i] >= '0' && s[i] <= '9') {
                current = current * 10 + (s[i] - '0');
                i++;
            }
            if (current <= prev) {
                return false;
            }
            prev = current;
        } else {
            i++;
        }
    }

    return true;
}