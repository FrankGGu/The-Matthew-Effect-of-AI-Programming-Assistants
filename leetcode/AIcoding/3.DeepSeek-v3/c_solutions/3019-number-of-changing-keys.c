int countKeyChanges(char* s) {
    int count = 0;
    for (int i = 1; s[i] != '\0'; i++) {
        if (tolower(s[i]) != tolower(s[i-1])) {
            count++;
        }
    }
    return count;
}