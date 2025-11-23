bool areNumbersAscending(char* s) {
    int prev = -1;
    int curr = 0;
    int i = 0;

    while (s[i] != '\0') {
        if (isdigit(s[i])) {
            curr = 0;
            while (s[i] != '\0' && isdigit(s[i])) {
                curr = curr * 10 + (s[i] - '0');
                i++;
            }
            if (prev >= curr) {
                return false;
            }
            prev = curr;
        } else {
            i++;
        }
    }
    return true;
}