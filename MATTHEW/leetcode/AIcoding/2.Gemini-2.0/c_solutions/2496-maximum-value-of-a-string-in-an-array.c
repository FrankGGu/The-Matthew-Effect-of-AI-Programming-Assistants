#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumValue(char ** strs, int strsSize){
    int max_val = 0;
    for (int i = 0; i < strsSize; i++) {
        int num = 0;
        int is_numeric = 1;
        for (int j = 0; strs[i][j] != '\0'; j++) {
            if (!isdigit(strs[i][j])) {
                is_numeric = 0;
                break;
            }
        }

        if (is_numeric) {
            num = atoi(strs[i]);
        } else {
            num = strlen(strs[i]);
        }

        if (num > max_val) {
            max_val = num;
        }
    }
    return max_val;
}