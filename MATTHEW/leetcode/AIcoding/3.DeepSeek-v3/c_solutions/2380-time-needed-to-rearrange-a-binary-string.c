int secondsToRemoveOccurrences(char* s) {
    int seconds = 0;
    int changed = 1;

    while (changed) {
        changed = 0;
        for (int i = 0; s[i + 1] != '\0'; i++) {
            if (s[i] == '0' && s[i + 1] == '1') {
                s[i] = '1';
                s[i + 1] = '0';
                changed = 1;
                i++;
            }
        }
        if (changed) {
            seconds++;
        }
    }

    return seconds;
}