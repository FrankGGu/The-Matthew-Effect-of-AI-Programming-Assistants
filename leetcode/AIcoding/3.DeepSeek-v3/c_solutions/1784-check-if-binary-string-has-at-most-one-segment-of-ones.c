bool checkOnesSegment(char* s) {
    int i = 0;
    while (s[i] != '\0') {
        if (s[i] == '1') {
            i++;
        } else {
            break;
        }
    }
    while (s[i] != '\0') {
        if (s[i] == '1') {
            return false;
        }
        i++;
    }
    return true;
}