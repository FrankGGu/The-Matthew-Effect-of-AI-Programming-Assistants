int countAsterisks(char* s) {
    int count = 0;
    int inPair = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '|') {
            inPair = !inPair;
        } else if (s[i] == '*' && !inPair) {
            count++;
        }
    }

    return count;
}