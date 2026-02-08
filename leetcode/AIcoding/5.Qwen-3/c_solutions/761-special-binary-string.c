#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* splitString(char* s, int* i) {
    int count = 0;
    char* result = (char*)malloc(sizeof(char) * (strlen(s) + 1));
    int index = 0;
    while (*i < strlen(s)) {
        if (s[*i] == '1') {
            count++;
        } else {
            count--;
        }
        result[index++] = s[*i];
        (*i)++;
        if (count == 0) {
            break;
        }
    }
    result[index] = '\0';
    return result;
}

char* specialBinaryString(char* s) {
    int count = 0;
    int i = 0;
    char* result = (char*)malloc(sizeof(char) * (strlen(s) + 1));
    int index = 0;
    while (i < strlen(s)) {
        if (s[i] == '1') {
            count++;
        } else {
            count--;
        }
        if (count == 0) {
            char* sub = splitString(s + i, &i);
            char* temp = specialBinaryString(sub + 1);
            char* newSub = (char*)malloc(sizeof(char) * (strlen(temp) + 3));
            sprintf(newSub, "1%s%s", temp, "0");
            strcat(result, newSub);
            free(sub);
            free(temp);
            free(newSub);
        } else {
            result[index++] = s[i++];
        }
    }
    result[index] = '\0';
    return result;
}