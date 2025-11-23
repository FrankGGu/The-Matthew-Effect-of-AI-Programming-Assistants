int strongPasswordChecker(char* password) {
    int len = strlen(password);
    int has_lower = 0, has_upper = 0, has_digit = 0;

    for (int i = 0; i < len; i++) {
        if (islower(password[i])) has_lower = 1;
        if (isupper(password[i])) has_upper = 1;
        if (isdigit(password[i])) has_digit = 1;
    }

    int missing_types = 3 - (has_lower + has_upper + has_digit);

    if (len < 6) {
        return fmax(missing_types, 6 - len);
    }

    int replace = 0;
    int one_mod = 0, two_mod = 0;
    int i = 0;
    while (i < len) {
        int j = i;
        while (j < len && password[j] == password[i]) j++;
        int count = j - i;
        if (count >= 3) {
            replace += count / 3;
            if (count % 3 == 0) one_mod++;
            else if (count % 3 == 1) two_mod++;
        }
        i = j;
    }

    if (len <= 20) {
        return fmax(missing_types, replace);
    }

    int delete = len - 20;
    replace -= fmin(delete, one_mod);
    replace -= fmin(fmax(delete - one_mod, 0), two_mod * 2) / 2;
    replace -= fmax(delete - one_mod - two_mod * 2, 0) / 3;

    return delete + fmax(missing_types, replace);
}