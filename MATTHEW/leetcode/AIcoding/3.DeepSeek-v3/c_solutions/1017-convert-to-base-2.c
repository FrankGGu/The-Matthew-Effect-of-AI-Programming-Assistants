char* baseNeg2(int n) {
    if (n == 0) {
        char* result = (char*)malloc(2 * sizeof(char));
        result[0] = '0';
        result[1] = '\0';
        return result;
    }

    char* result = (char*)malloc(32 * sizeof(char));
    int index = 0;

    while (n != 0) {
        int remainder = n % (-2);
        n = n / (-2);

        if (remainder < 0) {
            remainder += 2;
            n += 1;
        }

        result[index++] = remainder + '0';
    }

    result[index] = '\0';

    for (int i = 0; i < index / 2; i++) {
        char temp = result[i];
        result[i] = result[index - i - 1];
        result[index - i - 1] = temp;
    }

    return result;
}