#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int rotatedDigits(int n) {
    int count = 0;
    for (int i = 1; i <= n; i++) {
        char s[10];
        sprintf(s, "%d", i);
        int valid = 1;
        int hasChanged = 0;
        for (int j = 0; j < strlen(s); j++) {
            if (s[j] == '2' || s[j] == '5' || s[j] == '6' || s[j] == '9') {
                hasChanged = 1;
            } else if (s[j] == '3' || s[j] == '4' || s[j] == '7') {
                valid = 0;
                break;
            }
        }
        if (valid && hasChanged) {
            count++;
        }
    }
    return count;
}