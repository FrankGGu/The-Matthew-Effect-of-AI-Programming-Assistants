int maxDiff(int num) {
    char str[11];
    sprintf(str, "%d", num);
    int len = strlen(str);

    // Replace first occurrence of '1' with '9' for max
    char maxStr[11];
    strcpy(maxStr, str);
    for (int i = 0; i < len; i++) {
        if (maxStr[i] == '1') {
            maxStr[i] = '9';
            break;
        }
    }

    // Replace first occurrence of '0' with '1' for min
    char minStr[11];
    strcpy(minStr, str);
    for (int i = 0; i < len; i++) {
        if (minStr[i] == '0') {
            minStr[i] = '1';
            break;
        } else if (i == 0 && minStr[i] != '1') {
            minStr[i] = '0';
            break;
        }
    }

    return atoi(maxStr) - atoi(minStr);
}