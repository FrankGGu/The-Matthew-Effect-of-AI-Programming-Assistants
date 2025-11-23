#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool strongPasswordCheckerII(char * password) {
    int hasLower = 0;
    int hasUpper = 0;
    int hasDigit = 0;
    int hasSpecial = 0;
    int consecutive = 0;

    if (strlen(password) < 8) return false;

    for (int i = 0; i < strlen(password); i++) {
        if (password[i] >= 'a' && password[i] <= 'z') hasLower = 1;
        else if (password[i] >= 'A' && password[i] <= 'Z') hasUpper = 1;
        else if (password[i] >= '0' && password[i] <= '9') hasDigit = 1;
        else if ((password[i] >= '!' && password[i] <= '/') || 
                 (password[i] >= ':' && password[i] <= '@') || 
                 (password[i] >= '[' && password[i] <= '`') || 
                 (password[i] >= '{' && password[i] <= '~')) hasSpecial = 1;

        if (i > 0 && password[i] == password[i-1]) consecutive = 1;
    }

    return hasLower && hasUpper && hasDigit && hasSpecial && !consecutive;
}