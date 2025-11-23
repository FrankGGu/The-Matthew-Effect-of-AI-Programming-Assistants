#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * removeDigit(char * number, char digit){
    int n = strlen(number);
    char *res = NULL;
    for (int i = 0; i < n; i++) {
        if (number[i] == digit) {
            char *temp = (char *)malloc((n) * sizeof(char));
            strncpy(temp, number, i);
            temp[i] = '\0';
            strcat(temp, number + i + 1);

            if (res == NULL || strcmp(temp, res) > 0) {
                if(res != NULL){
                    free(res);
                }
                res = temp;
            } else {
                free(temp);
            }
        }
    }
    return res;
}