#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* decodeString(char* s) {
    int len = strlen(s);
    char* stack[len];
    int top = -1;
    char* res = (char*)malloc(sizeof(char) * (len * 2 + 1));
    res[0] = '\0';
    int res_len = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] != ']') {
            char* temp = (char*)malloc(sizeof(char) * 2);
            temp[0] = s[i];
            temp[1] = '\0';
            stack[++top] = temp;
        } else {
            char* str = (char*)malloc(sizeof(char) * (len * 2 + 1));
            str[0] = '\0';
            int str_len = 0;

            while (strcmp(stack[top], "[") != 0) {
                str_len += strlen(stack[top]);
                char* temp = (char*)malloc(sizeof(char) * (str_len + 1));
                strcpy(temp, stack[top]);
                strcat(temp, str);
                strcpy(str, temp);
                free(temp);
                free(stack[top]);
                top--;
            }
            free(stack[top]);
            top--;

            int num = 0;
            int power = 1;
            while (top >= 0 && stack[top][0] >= '0' && stack[top][0] <= '9') {
                num += (stack[top][0] - '0') * power;
                power *= 10;
                free(stack[top]);
                top--;
            }

            char* decoded = (char*)malloc(sizeof(char) * (strlen(str) * num + 1));
            decoded[0] = '\0';
            for (int j = 0; j < num; j++) {
                strcat(decoded, str);
            }

            stack[++top] = decoded;
            free(str);
        }
    }

    while (top >= 0) {
        res_len += strlen(stack[top]);
        char* temp = (char*)malloc(sizeof(char) * (res_len + 1));
        strcpy(temp, stack[top]);
        strcat(temp, res);
        strcpy(res, temp);
        free(temp);
        free(stack[top]);
        top--;
    }

    return res;
}