char* maskPII(char* S) {
    char* result = (char*)malloc(100 * sizeof(char));
    int len = strlen(S);

    if (strchr(S, '@')) {
        char* at = strchr(S, '@');
        *at = '\0';
        snprintf(result, 100, "%c*****%c%s", tolower(S[0]), tolower(S[len - 1]), at);
    } else {
        int digitCount = 0;
        for (int i = 0; i < len; i++) {
            if (isdigit(S[i])) digitCount++;
        }
        if (digitCount > 10) {
            snprintf(result, 100, "+***-***-***-%c%c%c%c%c%c%c%c%c%c", S[len - 10], S[len - 9], S[len - 8], S[len - 7], S[len - 6], S[len - 5], S[len - 4], S[len - 3], S[len - 2], S[len - 1]);
        } else {
            snprintf(result, 100, "***-***-%c%c%c%c%c%c", S[len - 6], S[len - 5], S[len - 4], S[len - 3], S[len - 2], S[len - 1]);
        }
    }

    return result;
}