bool areDigitsEqual(char * num) {
    char firstDigit = num[0];
    for (int i = 1; num[i] != '\0'; i++) {
        if (num[i] != firstDigit) {
            return false;
        }
    }
    return true;
}