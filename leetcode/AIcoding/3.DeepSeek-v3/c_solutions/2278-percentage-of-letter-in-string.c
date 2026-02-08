int percentageLetter(char* s, char letter) {
    int count = 0;
    int len = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        len++;
        if (s[i] == letter) {
            count++;
        }
    }

    return (count * 100) / len;
}