double percentageLetter(char *s, char letter) {
    int count = 0, length = 0;
    while (s[length] != '\0') {
        if (s[length] == letter) {
            count++;
        }
        length++;
    }
    return (double)count / length * 100;
}