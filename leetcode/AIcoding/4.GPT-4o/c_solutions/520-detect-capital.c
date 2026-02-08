bool detectCapitalUse(char * word) {
    int length = strlen(word);
    if (length == 0) return false;

    bool firstCapital = isupper(word[0]);
    bool allCapital = isupper(word[1]);
    bool allLower = islower(word[1]);

    if (length == 1) return true;

    if (firstCapital) {
        if (allCapital) {
            for (int i = 2; i < length; i++) {
                if (islower(word[i])) return false;
            }
            return true;
        } else if (allLower) {
            for (int i = 1; i < length; i++) {
                if (isupper(word[i])) return false;
            }
            return true;
        } else {
            return false;
        }
    } else {
        for (int i = 0; i < length; i++) {
            if (isupper(word[i])) return false;
        }
        return true;
    }
}