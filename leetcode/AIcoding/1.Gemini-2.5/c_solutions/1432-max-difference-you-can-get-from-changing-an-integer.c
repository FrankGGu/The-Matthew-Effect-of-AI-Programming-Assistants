#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void intToStr(int n, char* s) {
    sprintf(s, "%d", n);
}

int calculateMax(int num) {
    char s_arr[12];
    intToStr(num, s_arr);
    int len = strlen(s_arr);

    char digit_to_replace = '\0';
    for (int i = 0; i < len; i++) {
        if (s_arr[i] != '9') {
            digit_to_replace = s_arr[i];
            break;
        }
    }

    if (digit_to_replace == '\0') {
        return num;
    }

    for (int i = 0; i < len; i++) {
        if (s_arr[i] == digit_to_replace) {
            s_arr[i] = '9';
        }
    }
    return atoi(s_arr);
}

int calculateMin(int num) {
    char s_arr[12];
    intToStr(num, s_arr);
    int len = strlen(s_arr);

    if (len == 1) {
        return 0;
    }

    char digit_to_replace = '\0';
    char replace_with = '\0';

    if (s_arr[0] != '1') {
        digit_to_replace = s_arr[0];
        replace_with = '1';
    } else {
        for (int i = 1; i < len; i++) {
            if (s_arr[i] != '0' && s_arr[i] != '1') {
                digit_to_replace = s_arr[i];
                replace_with = '0';
                break;
            }
        }
    }

    if (digit_to_replace == '\0') {
        return num;
    }

    for (int i = 0; i < len; i++) {
        if (s_arr[i] == digit_to_replace) {
            s_arr[i] = replace_with;
        }
    }
    return atoi(s_arr);
}

int maxDiff(int num) {
    int max_val = calculateMax(num);
    int min_val = calculateMin(num);
    return max_val - min_val;
}