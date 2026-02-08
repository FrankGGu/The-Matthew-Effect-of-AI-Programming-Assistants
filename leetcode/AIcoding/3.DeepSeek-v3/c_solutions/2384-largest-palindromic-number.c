char* largestPalindromic(char* num) {
    int count[10] = {0};
    int len = strlen(num);
    for (int i = 0; i < len; i++) {
        count[num[i] - '0']++;
    }

    char* result = malloc(len + 1);
    int left = 0, right = len - 1;
    result[len] = '\0';

    for (int digit = 9; digit >= 0; digit--) {
        if (digit == 0 && left == 0) continue;
        while (count[digit] > 1) {
            result[left++] = digit + '0';
            result[right--] = digit + '0';
            count[digit] -= 2;
        }
    }

    for (int digit = 9; digit >= 0; digit--) {
        if (count[digit] > 0) {
            result[left] = digit + '0';
            break;
        }
    }

    if (result[0] == '0') {
        if (left == right && result[left] == '0') {
            result[1] = '\0';
            return result;
        }
    }

    return result;
}