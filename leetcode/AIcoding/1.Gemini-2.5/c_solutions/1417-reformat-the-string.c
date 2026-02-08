#include <string.h>
#include <stdlib.h>

char * reformat(char * s){
    int len = strlen(s);
    char* digits = (char*)malloc(sizeof(char) * (len + 1));
    char* alphas = (char*)malloc(sizeof(char) * (len + 1));
    int d_idx = 0;
    int a_idx = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] >= '0' && s[i] <= '9') {
            digits[d_idx++] = s[i];
        } else {
            alphas[a_idx++] = s[i];
        }
    }
    digits[d_idx] = '\0';
    alphas[a_idx] = '\0';

    char* result = (char*)malloc(sizeof(char) * (len + 1));
    int r_idx = 0;

    if (abs(d_idx - a_idx) > 1) {
        free(digits);
        free(alphas);
        free(result);
        return "";
    }

    if (d_idx > a_idx) {
        for (int i = 0; i < a_idx; i++) {
            result[r_idx++] = digits[i];
            result[r_idx++] = alphas[i];
        }
        result[r_idx++] = digits[d_idx - 1];
    } else if (a_idx > d_idx) {
        for (int i = 0; i < d_idx; i++) {
            result[r_idx++] = alphas[i];
            result[r_idx++] = digits[i];
        }
        result[r_idx++] = alphas[a_idx - 1];
    } else { // d_idx == a_idx
        for (int i = 0; i < d_idx; i++) {
            result[r_idx++] = alphas[i];
            result[r_idx++] = digits[i];
        }
    }
    result[r_idx] = '\0';

    free(digits);
    free(alphas);
    return result;
}