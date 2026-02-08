#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * largestGoodInteger(char * num){
    char ans[4] = "";
    for (int i = 0; i < strlen(num) - 2; i++) {
        if (num[i] == num[i+1] && num[i+1] == num[i+2]) {
            char temp[4] = {num[i], num[i], num[i], '\0'};
            if (strcmp(temp, ans) > 0) {
                strcpy(ans, temp);
            }
        }
    }
    if (strlen(ans) == 0) {
        return "";
    } else {
        char *result = (char*)malloc(sizeof(char) * 4);
        strcpy(result, ans);
        return result;
    }
}