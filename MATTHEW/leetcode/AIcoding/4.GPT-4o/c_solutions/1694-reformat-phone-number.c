char *reformatNumber(char *number) {
    int n = 0, count = 0;
    char *formatted = (char *)malloc(3 * strlen(number) + 1);
    for (int i = 0; number[i]; i++) {
        if (number[i] >= '0' && number[i] <= '9') {
            if (count > 0 && count % 3 == 0) {
                formatted[n++] = '-';
            }
            formatted[n++] = number[i];
            count++;
        }
    }
    if (count % 3 == 1) {
        formatted[n - 2] = '-';
        n++;
        formatted[n++] = formatted[n - 3];
        formatted[n - 3] = formatted[n - 4];
    }
    formatted[n] = '\0';
    return formatted;
}