int countAsterisks(char * s) {
    int count = 0, barCount = 0;
    while (*s) {
        if (*s == '|') {
            barCount++;
        } else if (*s == '*' && barCount % 2 == 0) {
            count++;
        }
        s++;
    }
    return count;
}