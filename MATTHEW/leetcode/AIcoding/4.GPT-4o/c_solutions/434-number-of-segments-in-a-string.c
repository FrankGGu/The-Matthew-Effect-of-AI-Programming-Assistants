int countSegments(char *s) {
    int count = 0;
    int inSegment = 0;

    while (*s) {
        if (*s != ' ') {
            if (!inSegment) {
                count++;
                inSegment = 1;
            }
        } else {
            inSegment = 0;
        }
        s++;
    }

    return count;
}