#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* getStrongPassword(int n, char** password) {
    char* result = (char*)malloc(n + 1);
    int index = 0;
    for (int i = n - 1; i >= 0; i--) {
        if (password[i][0] == 'a' || password[i][0] == 'e' || password[i][0] == 'i' || password[i][0] == 'o' || password[i][0] == 'u') {
            result[index++] = password[i][0];
        } else {
            result[index++] = password[i][0];
            result[index++] = password[i][0];
        }
    }
    result[index] = '\0';
    return result;
}