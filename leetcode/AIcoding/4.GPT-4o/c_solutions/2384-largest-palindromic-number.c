char *largestPalindromic(char *num) {
    int count[10] = {0};
    for (int i = 0; num[i]; i++) {
        count[num[i] - '0']++;
    }

    char left[1001] = {0};
    char middle = '\0';
    int index = 0;

    for (int i = 9; i >= 0; i--) {
        if (count[i] % 2 == 1) {
            if (middle < '0' + i) {
                middle = '0' + i;
            }
        }
        for (int j = 0; j < count[i] / 2; j++) {
            left[index++] = '0' + i;
        }
    }

    if (index == 0 && middle == '\0') return "0";

    char *result = (char *)malloc(2002);
    if (index > 0) {
        int len = index;
        for (int i = 0; i < len; i++) result[i] = left[len - 1 - i];
        result[len] = middle;
        for (int i = 0; i < len; i++) result[len + 1 + i] = left[i];
        result[len + (middle ? 1 : 0) + len] = '\0';
    } else {
        result[0] = middle;
        result[1] = '\0';
    }

    return result;
}