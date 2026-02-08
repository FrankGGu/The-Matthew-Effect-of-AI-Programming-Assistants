#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDiff(int num) {
    char s[11];
    sprintf(s, "%d", num);
    int n = strlen(s);

    int max_num = num;
    for (int i = 0; i < n; i++) {
        char original = s[i];
        if (original != '9') {
            char temp[11];
            strcpy(temp, s);
            for (int j = 0; j < n; j++) {
                if (temp[j] == original) {
                    temp[j] = '9';
                }
            }
            max_num = atoi(temp) > max_num ? atoi(temp) : max_num;
            break;
        }
    }

    int min_num = num;
    for (int i = 0; i < n; i++) {
        char original = s[i];
        char replace;
        if (i == 0) {
            if (original != '1') {
                replace = '1';
            } else {
                continue;
            }
        } else {
            if (original != '0' && original != s[0]) {
                replace = '0';
            } else {
                continue;
            }
        }

        char temp[11];
        strcpy(temp, s);
        for (int j = 0; j < n; j++) {
            if (temp[j] == original) {
                temp[j] = replace;
            }
        }
        min_num = atoi(temp) < min_num ? atoi(temp) : min_num;
        break;
    }

    return max_num - min_num;
}