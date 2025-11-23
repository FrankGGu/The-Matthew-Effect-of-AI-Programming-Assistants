char * thousandSeparator(int n) {
    char *result = (char *)malloc(32);
    int len = 0, count = 0, temp = n;

    if (n == 0) {
        strcpy(result, "0");
        return result;
    }

    while (temp > 0) {
        temp /= 10;
        len++;
    }

    int index = len + len / 3; // for the commas
    result[index] = '\0';
    index--;

    for (int i = len - 1; i >= 0; i--) {
        if (count > 0 && count % 3 == 0) {
            result[index--] = '.';
        }
        result[index--] = (n % 10) + '0';
        n /= 10;
        count++;
    }

    return result + index + 1;
}