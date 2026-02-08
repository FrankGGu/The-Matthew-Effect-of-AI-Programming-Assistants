char *fractionToDecimal(int numerator, int denominator) {
    if (numerator == 0) return "0";

    char *result = (char *)malloc(10000);
    int index = 0;

    if ((numerator < 0) ^ (denominator < 0)) result[index++] = '-';

    long num = labs(numerator);
    long denom = labs(denominator);

    long integerPart = num / denom;
    result[index++] = integerPart + '0';

    long remainder = num % denom;
    if (remainder == 0) {
        result[index] = '\0';
        return result;
    }

    result[index++] = '.';
    int startIndex = index;
    int *map = (int *)malloc(denom * sizeof(int));

    while (remainder != 0) {
        if (map[remainder] > 0) {
            int pos = map[remainder] + startIndex;
            result[pos] = ')';
            result[index++] = '(';
            break;
        }
        map[remainder] = index - startIndex;
        remainder *= 10;
        result[index++] = (remainder / denom) + '0';
        remainder %= denom;
    }

    result[index] = '\0';
    free(map);
    return result;
}