#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* interpret(char* command) {
    int len = strlen(command);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;

    for (int i = 0; i < len; i++) {
        if (command[i] == 'G') {
            result[index++] = 'G';
        } else if (command[i] == '(' && command[i+1] == ')') {
            result[index++] = 'o';
            i += 1;
        } else if (command[i] == '(' && command[i+1] == 'a' && command[i+2] == 'l' && command[i+3] == ')') {
            result[index++] = 'a';
            result[index++] = 'l';
            i += 3;
        }
    }

    result[index] = '\0';
    return result;
}