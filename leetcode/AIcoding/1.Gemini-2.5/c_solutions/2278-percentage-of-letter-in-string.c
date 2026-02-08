int percentageLetter(char * s, char letter){
    int count = 0;
    int length = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        length++;
        if (s[i] == letter) {
            count++;
        }
    }
    if (length == 0) {
        return 0;
    }
    return (count * 100) / length;
}