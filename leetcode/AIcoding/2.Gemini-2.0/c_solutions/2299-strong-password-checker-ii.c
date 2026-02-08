#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool strongPasswordCheckerII(char * password){
    int len = strlen(password);
    if (len < 8) return false;

    bool lower = false, upper = false, digit = false, special = false;
    char specialChars[] = "!@#$%^&*()-+";

    for (int i = 0; i < len; i++) {
        if (islower(password[i])) lower = true;
        else if (isupper(password[i])) upper = true;
        else if (isdigit(password[i])) digit = true;
        else {
            for (int j = 0; j < strlen(specialChars); j++) {
                if (password[i] == specialChars[j]) {
                    special = true;
                    break;
                }
            }
        }
    }

    if (!lower || !upper || !digit || !special) return false;

    for (int i = 0; i < len - 1; i++) {
        if (password[i] == password[i+1]) return false;
    }

    return true;
}