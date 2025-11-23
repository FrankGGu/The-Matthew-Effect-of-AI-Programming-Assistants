char findTheDifference(char* s, char* t) {
    char result = 0;
    while (*s) {
        result ^= *s;
        s++;
    }
    while (*t) {
        result ^= *t;
        t++;
    }
    return result;
}