#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * toHex(int num){
    if (num == 0) {
        char *result = (char *)malloc(2 * sizeof(char));
        result[0] = '0';
        result[1] = '\0';
        return result;
    }

    char *hex_map = "0123456789abcdef";
    char *result = (char *)malloc(9 * sizeof(char));
    int i = 7;

    unsigned int n = num;
    result[8] = '\0';

    while (n > 0) {
        result[i--] = hex_map[n % 16];
        n /= 16;
    }

    return result + i + 1;
}