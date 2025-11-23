#include <stdbool.h>
#include <string.h>

bool strongPasswordCheckerII(char *password) {
    int len = strlen(password);
    if (len < 8) return false;

    bool hasLower = false, hasUpper = false, hasDigit = false, hasSpecial = false;
    char specialChars[] = "!@#$%^&*()-+";

    for (int i = 0; i < len; i++) {
        if (password[i] >= 'a' && password[i] <= 'z') hasLower = true;
        if (password[i] >= 'A' && password[i] <= 'Z') hasUpper = true;
        if (password[i] >= '0' && password[i] <= '9') hasDigit = true;
        if (strchr(specialChars, password[i])) hasSpecial = true;
        if (i > 0 && password[i] == password[i - 1]) return false;
    }

    return hasLower && hasUpper && hasDigit && hasSpecial;
}