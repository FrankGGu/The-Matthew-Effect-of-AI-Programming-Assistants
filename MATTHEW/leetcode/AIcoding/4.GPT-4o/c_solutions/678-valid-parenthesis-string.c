bool checkValidString(char * s) {
    int low = 0, high = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '(') {
            low++;
            high++;
        } else if (s[i] == ')') {
            low--;
            high--;
        } else {
            low--;
            high++;
        }
        if (high < 0) return false;
        low = low < 0 ? 0 : low;
    }
    return low == 0;
}