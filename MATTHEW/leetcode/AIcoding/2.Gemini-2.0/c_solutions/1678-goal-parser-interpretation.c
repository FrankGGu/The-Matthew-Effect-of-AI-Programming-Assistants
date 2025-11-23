#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * interpret(char * command){
    int len = strlen(command);
    char *result = (char*)malloc(sizeof(char) * (len * 2 + 1));
    int result_index = 0;

    for (int i = 0; i < len; i++) {
        if (command[i] == 'G') {
            result[result_index++] = 'G';
        } else if (command[i] == '(') {
            if (command[i+1] == ')') {
                result[result_index++] = 'o';
                i++;
            } else {
                result[result_index++] = 'a';
                result[result_index++] = 'l';
                i += 3;
            }
        }
    }

    result[result_index] = '\0';
    return result;
}