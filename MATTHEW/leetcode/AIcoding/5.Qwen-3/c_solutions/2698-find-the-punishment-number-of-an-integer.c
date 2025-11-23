#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int is_valid(char *s, int target) {
    if (strlen(s) == 0) return target == 0;
    for (int i = 1; i <= strlen(s); i++) {
        char sub[10];
        strncpy(sub, s, i);
        sub[i] = '\0';
        int num = atoi(sub);
        if (num > target) break;
        if (is_valid(s + i, target - num)) return 1;
    }
    return 0;
}

int punishmentNumber(char* n) {
    int len = strlen(n);
    int target = atoi(n);
    char s[10];
    sprintf(s, "%d", target);
    return is_valid(s, target);
}