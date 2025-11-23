#include <stdlib.h>
#include <string.h>

char * largestGoodInteger(char * num){
    char max_digit = ' ';

    int n = strlen(num);

    for (int i = 0; i <= n - 3; i++) {
        if (num[i] == num[i+1] && num[i+1] == num[i+2]) {
            if (num[i] > max_digit) {
                max_digit = num[i];
            }
        }
    }

    if (max_digit == ' ') {
        char *result = (char *) malloc(sizeof(char) * 1);
        if (result == NULL) return NULL;
        result[0] = '\0';
        return result;
    } else {
        char *result = (char *) malloc(sizeof(char) * 4);
        if (result == NULL) return NULL;
        result[0] = max_digit;
        result[1] = max_digit;
        result[2] = max_digit;
        result[3] = '\0';
        return result;
    }
}