char * licenseKeyFormatting(char * s, int k) {
    int n = strlen(s);
    char *result = (char *)malloc(sizeof(char) * (n + (n / k) + 1));
    int j = 0, count = 0;

    for (int i = n - 1; i >= 0; i--) {
        if (s[i] != '-') {
            if (count == k) {
                result[j++] = '-';
                count = 0;
            }
            result[j++] = toupper(s[i]);
            count++;
        }
    }

    result[j] = '\0';
    strrev(result);
    return result;
}