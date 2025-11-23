#include <string.h>
#include <stdlib.h>

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

char * gcdOfStrings(char * str1, char * str2){
    int len1 = strlen(str1);
    int len2 = strlen(str2);

    char *temp1 = (char *)malloc(len1 + len2 + 1);
    char *temp2 = (char *)malloc(len1 + len2 + 1);

    strcpy(temp1, str1);
    strcat(temp1, str2);

    strcpy(temp2, str2);
    strcat(temp2, str1);

    if (strcmp(temp1, temp2) != 0) {
        free(temp1);
        free(temp2);
        char *result = (char *)malloc(1);
        result[0] = '\0';
        return result;
    }

    free(temp1);
    free(temp2);

    int gcd_length = gcd(len1, len2);

    char *result = (char *)malloc(gcd_length + 1);
    strncpy(result, str1, gcd_length);
    result[gcd_length] = '\0';

    return result;
}