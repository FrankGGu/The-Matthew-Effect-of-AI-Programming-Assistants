bool areDigitsEqual(char * num) {
    int firstDigit = num[0] - '0';
    for (int i = 1; num[i] != '\0'; i++) {
        if (num[i] - '0' != firstDigit) {
            return false;
        }
    }
    return true;
}