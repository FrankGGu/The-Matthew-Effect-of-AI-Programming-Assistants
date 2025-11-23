#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * alphabetBoardPath(char * target){
    int x = 0, y = 0;
    int len = strlen(target);
    char *res = (char *)malloc(sizeof(char) * (len * 5 + 1));
    int res_len = 0;
    for (int i = 0; i < len; i++) {
        int target_x = (target[i] - 'a') % 5;
        int target_y = (target[i] - 'a') / 5;

        if (target_y < y) {
            for (int j = 0; j < y - target_y; j++) {
                res[res_len++] = 'U';
            }
        }
        if (target_x < x) {
            for (int j = 0; j < x - target_x; j++) {
                res[res_len++] = 'L';
            }
        }
        if (target_x > x) {
            for (int j = 0; j < target_x - x; j++) {
                res[res_len++] = 'R';
            }
        }
        if (target_y > y) {
            for (int j = 0; j < target_y - y; j++) {
                res[res_len++] = 'D';
            }
        }
        res[res_len++] = '!';
        x = target_x;
        y = target_y;
    }
    res[res_len] = '\0';
    return res;
}