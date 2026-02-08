bool canBeValid(char * s, int sSize) {
    if (sSize % 2 != 0) return false;
    int low = 0, high = 0;
    for (int i = 0; i < sSize; i++) {
        low += (s[i] == '(') ? 1 : -1;
        high += (s[i] == ')') ? 1 : -1;
        if (high < 0) return false;
        low = low < 0 ? 0 : low;
    }
    return low == 0;
}