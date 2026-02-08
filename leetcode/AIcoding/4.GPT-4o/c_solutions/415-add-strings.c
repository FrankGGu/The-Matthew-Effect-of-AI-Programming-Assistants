char *addStrings(char *num1, char *num2) {
    int len1 = strlen(num1), len2 = strlen(num2);
    int carry = 0, i = 0, j = 0, k = 0;
    char *result = (char *)malloc((len1 > len2 ? len1 : len2) + 2);
    result[(len1 > len2 ? len1 : len2) + 1] = '\0';

    while (i < len1 || j < len2 || carry) {
        int sum = carry;
        if (i < len1) sum += num1[len1 - 1 - i++] - '0';
        if (j < len2) sum += num2[len2 - 1 - j++] - '0';
        result[k++] = (sum % 10) + '0';
        carry = sum / 10;
    }

    for (int l = 0; l < k / 2; l++) {
        char temp = result[l];
        result[l] = result[k - 1 - l];
        result[k - 1 - l] = temp;
    }

    return result;
}