char* smallestPalindromicRearrangement(char* s) {
    int count[10] = {0};
    int odd_count = 0, odd_digit = -1;
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        count[s[i] - '0']++;
    }

    for (int i = 0; i < 10; i++) {
        if (count[i] % 2 == 1) {
            odd_count++;
            odd_digit = i;
        }
    }

    if (odd_count > 1) return "";

    char* half = (char*)malloc(len + 1);
    int index = 0;

    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < count[i] / 2; j++) {
            half[index++] = i + '0';
        }
    }
    half[index] = '\0';

    char* result = (char*)malloc(len + 1);
    if (odd_digit != -1) {
        sprintf(result, "%s%d%s", half, odd_digit, strrev(half));
    } else {
        sprintf(result, "%s%s", half, strrev(half));
    }

    free(half);
    return result;
}

char* strrev(char* str) {
    int n = strlen(str);
    for (int i = 0; i < n / 2; i++) {
        char temp = str[i];
        str[i] = str[n - i - 1];
        str[n - i - 1] = temp;
    }
    return str;
}