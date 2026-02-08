bool checkString(char* s) {
    int foundB = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == 'b') {
            foundB = 1;
        } else if (s[i] == 'a' && foundB) {
            return false;
        }
    }
    return true;
}