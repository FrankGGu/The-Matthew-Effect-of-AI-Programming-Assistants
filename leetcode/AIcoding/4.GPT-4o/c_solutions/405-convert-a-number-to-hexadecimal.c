char* toHex(int num) {
    if (num == 0) return "0";
    char* hex = (char*)malloc(9);
    char* hexDigits = "0123456789abcdef";
    int index = 0;
    unsigned int uNum = num;
    while (uNum > 0 && index < 8) {
        hex[index++] = hexDigits[uNum % 16];
        uNum /= 16;
    }
    hex[index] = '\0';
    // Reverse the string
    for (int i = 0; i < index / 2; i++) {
        char temp = hex[i];
        hex[i] = hex[index - i - 1];
        hex[index - i - 1] = temp;
    }
    return hex;
}