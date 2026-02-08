char * greatestLetter(char * s) {
    int upper[26] = {0};
    int lower[26] = {0};

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] >= 'A' && s[i] <= 'Z') {
            upper[s[i] - 'A'] = 1;
        } else if (s[i] >= 'a' && s[i] <= 'z') {
            lower[s[i] - 'a'] = 1;
        }
    }

    for (int i = 25; i >= 0; i--) {
        if (upper[i] && lower[i]) {
            char* result = malloc(2 * sizeof(char));
            result[0] = 'A' + i;
            result[1] = '\0';
            return result;
        }
    }

    return "";
}