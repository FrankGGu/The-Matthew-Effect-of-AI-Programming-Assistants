char *addBinary(char *a, char *b) {
    int lenA = strlen(a), lenB = strlen(b);
    int maxLen = fmax(lenA, lenB);
    char *result = (char *)malloc(maxLen + 2);
    result[maxLen + 1] = '\0';

    int carry = 0, i = 0;
    for (i = 0; i < maxLen; i++) {
        int bitA = (lenA - 1 - i >= 0) ? a[lenA - 1 - i] - '0' : 0;
        int bitB = (lenB - 1 - i >= 0) ? b[lenB - 1 - i] - '0' : 0;

        int sum = bitA + bitB + carry;
        result[maxLen - i] = (sum % 2) + '0';
        carry = sum / 2;
    }

    if (carry) {
        result[0] = '1';
        return result;
    }

    return result + 1;
}