#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * reformat(char * s){
    int digits = 0;
    int letters = 0;
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        if (s[i] >= '0' && s[i] <= '9') {
            digits++;
        } else {
            letters++;
        }
    }

    if (abs(digits - letters) > 1) {
        return "";
    }

    char *digits_arr = (char *)malloc((digits + 1) * sizeof(char));
    char *letters_arr = (char *)malloc((letters + 1) * sizeof(char));
    int digits_idx = 0;
    int letters_idx = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] >= '0' && s[i] <= '9') {
            digits_arr[digits_idx++] = s[i];
        } else {
            letters_arr[letters_idx++] = s[i];
        }
    }
    digits_arr[digits] = '\0';
    letters_arr[letters] = '\0';

    char *result = (char *)malloc((n + 1) * sizeof(char));
    result[n] = '\0';

    int i = 0;
    int j = 0;
    int k = 0;

    if (digits > letters) {
        while (i < digits || j < letters) {
            if (i < digits) {
                result[k++] = digits_arr[i++];
            }
            if (j < letters) {
                result[k++] = letters_arr[j++];
            }
        }
    } else {
        while (i < digits || j < letters) {
            if (j < letters) {
                result[k++] = letters_arr[j++];
            }
            if (i < digits) {
                result[k++] = digits_arr[i++];
            }
        }
    }

    free(digits_arr);
    free(letters_arr);

    return result;
}