#include <stdio.h>
#include <string.h>

char* generateDynamicPassword(char* password) {
    int len = strlen(password);
    for (int i = 0; i < len; i++) {
        if (password[i] >= 'a' && password[i] <= 'z') {
            password[i] = 'a' + (password[i] - 'a' + 1) % 26;
        }
        else if (password[i] >= 'A' && password[i] <= 'Z') {
            password[i] = 'A' + (password[i] - 'A' + 1) % 26;
        }
    }
    return password;
}