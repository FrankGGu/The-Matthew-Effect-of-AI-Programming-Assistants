#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkBalancedString(char* s) {
    int count[4] = {0};
    int n = 0;
    while (s[n] != '\0') {
        n++;
    }

    for (int i = 0; i < n; i++) {
        if (s[i] == 'Q') {
            count[0]++;
        } else if (s[i] == 'W') {
            count[1]++;
        } else if (s[i] == 'E') {
            count[2]++;
        } else {
            count[3]++;
        }
    }

    int target = n / 4;
    if (count[0] <= target && count[1] <= target && count[2] <= target && count[3] <= target) {
        return true;
    }
    return false;
}