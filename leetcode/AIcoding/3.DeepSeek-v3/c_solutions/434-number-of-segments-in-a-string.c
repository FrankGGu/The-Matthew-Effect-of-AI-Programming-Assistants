int countSegments(char* s) {
    int count = 0;
    int i = 0;
    while (s[i] != '\0') {
        if (s[i] != ' ') {
            count++;
            while (s[i] != ' ' && s[i] != '\0') {
                i++;
            }
        } else {
            i++;
        }
    }
    return count;
}