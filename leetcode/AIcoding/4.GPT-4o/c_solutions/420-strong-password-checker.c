int strongPasswordChecker(char *password) {
    int n = strlen(password);
    int hasLower = 0, hasUpper = 0, hasDigit = 0;
    for (int i = 0; i < n; i++) {
        if (islower(password[i])) hasLower = 1;
        else if (isupper(password[i])) hasUpper = 1;
        else if (isdigit(password[i])) hasDigit = 1;
    }

    int categories = hasLower + hasUpper + hasDigit;
    if (n < 6) return 6 - n + (3 - categories);

    int replace = 0, one = 0, two = 0;
    int i = 2;
    while (i < n) {
        if (password[i] == password[i - 1] && password[i] == password[i - 2]) {
            int len = 2;
            while (i < n && password[i] == password[i - 1]) {
                len++;
                i++;
            }
            replace += len / 3;
            if (len % 3 == 0) one++;
            else if (len % 3 == 1) two++;
        } else {
            i++;
        }
    }

    if (n > 20) {
        int excess = n - 20;
        replace -= excess / 3;
        replace = replace < 0 ? 0 : replace;
        n = 20;
    }

    return (n < 6) ? 6 - n + (3 - categories) : (replace + (3 - categories) > 0 ? replace + (3 - categories) : replace);
}