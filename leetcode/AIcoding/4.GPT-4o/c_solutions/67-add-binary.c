char *addBinary(char *a, char *b) {
    int lenA = strlen(a), lenB = strlen(b);
    int maxLen = fmax(lenA, lenB) + 1;
    char *result = (char *)malloc(maxLen + 1);
    result[maxLen] = '\0';
    int carry = 0, i = 0;

    while (i < lenA || i < lenB || carry) {
        int sum = carry;
        if (i < lenA) sum += a[lenA - 1 - i] - '0';
        if (i < lenB) sum += b[lenB - 1 - i] - '0';
        result[maxLen - 1 - i] = (sum % 2) + '0';
        carry = sum / 2;
        i++;
    }

    return result + maxLen - 1 - i + (carry ? 0 : 1);
}