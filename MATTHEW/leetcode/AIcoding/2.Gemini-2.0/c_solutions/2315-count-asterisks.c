#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countAsterisks(char * s){
    int count = 0;
    int flag = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '|') {
            flag = 1 - flag;
        } else if (s[i] == '*' && flag == 0) {
            count++;
        }
    }
    return count;
}