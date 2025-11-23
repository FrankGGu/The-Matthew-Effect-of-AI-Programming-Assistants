int titleToNumber(char* columnTitle) {
    int result = 0;
    while (*columnTitle) {
        result = result * 26 + (*columnTitle - 'A' + 1);
        columnTitle++;
    }
    return result;
}