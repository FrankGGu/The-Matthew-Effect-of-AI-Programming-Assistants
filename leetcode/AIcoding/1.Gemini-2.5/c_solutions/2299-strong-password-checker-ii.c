#include <stdbool.h>
#include <string.h>
#include <ctype.h>

bool strongPasswordCheckerII(char * password){
    int len = strlen(password);

    if (len < 8) {
        return false;
    }

    bool hasLower = false;
    bool hasUpper = false;
    bool hasDigit = false;
    bool hasSpecial = false;

    const char* specialChars = "!@#$%^&*()-+";

    for (int i = 0; i < len; i++) {
        char c = password[i];

        if (islower(c)) {
            hasLower = true;
        } else if (isupper(c)) {
            hasUpper = true;
        } else if (isdigit(c)) {
            hasDigit = true;
        } else if (strchr(specialChars, c) != NULL) {
            hasSpecial = true;
        }

        if (i > 0 && password[i] == password[i-1]) {
            return false;
        }
    }

    return hasLower && hasUpper && hasDigit && hasSpecial;
}