char * thousandSeparator(int n){
    if (n == 0) {
        char *result = malloc(2);
        result[0] = '0';
        result[1] = '\0';
        return result;
    }

    char buffer[20];
    int idx = 0;
    int count = 0;

    while (n > 0) {
        if (count > 0 && count % 3 == 0) {
            buffer[idx++] = '.';
        }
        buffer[idx++] = '0' + (n % 10);
        n /= 10;
        count++;
    }

    char *result = malloc(idx + 1);
    for (int i = 0; i < idx; i++) {
        result[i] = buffer[idx - 1 - i];
    }
    result[idx] = '\0';

    return result;
}