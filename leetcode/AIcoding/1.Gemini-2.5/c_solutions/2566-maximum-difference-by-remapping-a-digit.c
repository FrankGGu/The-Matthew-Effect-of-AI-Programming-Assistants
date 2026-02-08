#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int convertAndReplace(int num, char old_digit, char new_digit) {
    char s[12];
    sprintf(s, "%d", num);
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        if (s[i] == old_digit) {
            s[i] = new_digit;
        }
    }
    return atoi(s);
}

int maxDiff(int num) {
    char s[12];
    sprintf(s, "%d", num);
    int len = strlen(s);

    char c_to_replace_max = ' ';
    for (int i = 0; i < len; i++) {
        if (s[i] != '9') {
            c_to_replace_max = s[i];
            break;
        }
    }

    int max_val;
    if (c_to_replace_max != ' ') {
        max_val = convertAndReplace(num, c_to_replace_max, '9');
    } else {
        max_val = num;
    }

    char c_to_replace_min = s[0];
    int min_val = convertAndReplace(num, c_to_replace_min, '0');

    return max_val - min_val;
}