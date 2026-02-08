#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDiff(int num) {
    char s[10];
    sprintf(s, "%d", num);
    int n = strlen(s);
    int max_val = 0;
    int min_val = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] != '9') {
            max_val = 0;
            for (int j = 0; j < n; j++) {
                if (s[j] == s[i]) {
                    max_val = max_val * 10 + 9;
                } else {
                    max_val = max_val * 10 + (s[j] - '0');
                }
            }
            break;
        }
    }
    if (max_val == 0) {
        max_val = num;
    }
    for (int i = 0; i < n; i++) {
        if (s[i] != '1') {
            min_val = 0;
            for (int j = 0; j < n; j++) {
                if (s[j] == s[i]) {
                    min_val = min_val * 10 + 1;
                } else {
                    min_val = min_val * 10 + (s[j] - '0');
                }
            }
            break;
        }
    }
    if (min_val == 0) {
        min_val = num;
    }
    return max_val - min_val;
}