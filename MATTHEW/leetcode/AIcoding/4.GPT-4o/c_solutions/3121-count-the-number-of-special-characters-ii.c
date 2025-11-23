int countSpecialCharacters(char * s) {
    int count = 0;
    while (*s) {
        if (!isalnum(*s)) {
            count++;
        }
        s++;
    }
    return count;
}