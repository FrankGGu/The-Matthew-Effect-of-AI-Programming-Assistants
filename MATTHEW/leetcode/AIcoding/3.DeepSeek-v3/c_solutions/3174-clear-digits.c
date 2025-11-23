char* clearDigits(char* s) {
    int top = -1;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] >= '0' && s[i] <= '9') {
            if (top >= 0) {
                top--;
            }
        } else {
            top++;
            s[top] = s[i];
        }
    }
    s[top + 1] = '\0';
    return s;
}