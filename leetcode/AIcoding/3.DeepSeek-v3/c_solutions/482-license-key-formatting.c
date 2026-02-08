char * licenseKeyFormatting(char * s, int k) {
    int len = strlen(s);
    int count = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] != '-') {
            count++;
        }
    }

    if (count == 0) {
        return "";
    }

    int groups = (count + k - 1) / k;
    int totalLen = count + groups - 1;
    char *result = (char *)malloc(totalLen + 1);
    result[totalLen] = '\0';

    int j = totalLen - 1;
    int current = 0;

    for (int i = len - 1; i >= 0; i--) {
        if (s[i] != '-') {
            if (current > 0 && current % k == 0) {
                result[j--] = '-';
            }
            result[j--] = toupper(s[i]);
            current++;
        }
    }

    return result;
}