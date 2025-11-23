#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int crackPassword(char *password) {
    int len = strlen(password);
    int count = 0;
    for (int i = 0; i < len; i++) {
        if (password[i] >= '0' && password[i] <= '9') {
            count++;
        }
    }
    return count;
}