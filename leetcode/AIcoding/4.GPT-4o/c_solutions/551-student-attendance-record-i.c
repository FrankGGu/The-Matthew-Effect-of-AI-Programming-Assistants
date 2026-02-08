bool checkRecord(char * s) {
    int aCount = 0, lCount = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == 'A') {
            aCount++;
            if (aCount > 1) return false;
        }
        if (s[i] == 'L') {
            lCount++;
            if (lCount > 2) return false;
        } else {
            lCount = 0;
        }
    }

    return true;
}