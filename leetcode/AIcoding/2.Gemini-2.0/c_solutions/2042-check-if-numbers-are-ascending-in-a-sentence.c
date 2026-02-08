#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool areNumbersAscending(char * s){
    int prev = -1;
    char *token = strtok(s, " ");
    while (token != NULL) {
        if (isdigit(token[0])) {
            int num = atoi(token);
            if (num <= prev) {
                return false;
            }
            prev = num;
        }
        token = strtok(NULL, " ");
    }
    return true;
}