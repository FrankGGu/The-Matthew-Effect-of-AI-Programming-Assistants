char* toHex(int num) {
    if (num == 0) return "0";

    char hex[] = "0123456789abcdef";
    char* result = malloc(9 * sizeof(char));
    int index = 0;
    unsigned int n = num;

    while (n != 0) {
        result[index++] = hex[n & 0xf];
        n >>= 4;
    }
    result[index] = '\0';

    for (int i = 0, j = index - 1; i < j; i++, j--) {
        char temp = result[i];
        result[i] = result[j];
        result[j] = temp;
    }

    return result;
}