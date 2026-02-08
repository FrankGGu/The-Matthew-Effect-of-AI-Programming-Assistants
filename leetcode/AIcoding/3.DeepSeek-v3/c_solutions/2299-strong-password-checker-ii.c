bool strongPasswordCheckerII(char* password) {
    int len = strlen(password);
    if (len < 8) return false;

    bool hasLower = false, hasUpper = false, hasDigit = false, hasSpecial = false;
    char* special = "!@#$%^&*()-+";

    for (int i = 0; i < len; i++) {
        if (i > 0 && password[i] == password[i-1]) return false;

        if (islower(password[i])) hasLower = true;
        else if (isupper(password[i])) hasUpper = true;
        else if (isdigit(password[i])) hasDigit = true;
        else if (strchr(special, password[i])) hasSpecial = true;
    }

    return hasLower && hasUpper && hasDigit && hasSpecial;
}