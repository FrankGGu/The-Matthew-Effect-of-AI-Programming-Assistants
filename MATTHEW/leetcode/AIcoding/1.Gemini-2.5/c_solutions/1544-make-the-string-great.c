#include <string.h>
#include <stdlib.h>
#include <math.h>

char * makeGood(char * s){
    int n = strlen(s);
    if (n == 0) {
        char *empty_str = (char *)malloc(sizeof(char));
        empty_str[0] = '\0';
        return empty_str;
    }

    char *res = (char *)malloc((n + 1) * sizeof(char));
    int res_idx = 0;

    for (int i = 0; i < n; i++) {
        char current_char = s[i];

        if (res_idx > 0) {
            char last_char_in_res = res[res_idx - 1];
            if (abs(current_char - last_char_in_res) == 32) {
                res_idx--;
            } else {
                res[res_idx] = current_char;
                res_idx++;
            }
        } else {
            res[res_idx] = current_char;
            res_idx++;
        }
    }

    res[res_idx] = '\0';
    return res;
}