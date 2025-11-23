char* baseNeg2(int n) {
    if (n == 0) return "0";
    char* result = (char*)malloc(33);
    int index = 0;
    while (n != 0) {
        int remainder = n & 1;
        result[index++] = '0' + remainder;
        n = (n - remainder) / -2;
    }
    result[index] = '\0';
    // Reverse the result
    for (int i = 0; i < index / 2; i++) {
        char temp = result[i];
        result[i] = result[index - 1 - i];
        result[index - 1 - i] = temp;
    }
    return result;
}