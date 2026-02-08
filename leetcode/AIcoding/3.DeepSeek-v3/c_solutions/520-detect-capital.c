bool detectCapitalUse(char* word) {
    int len = strlen(word);
    if (len == 1) return true;

    bool firstUpper = isupper(word[0]);
    bool secondUpper = isupper(word[1]);

    if (!firstUpper && secondUpper) return false;

    for (int i = 2; i < len; i++) {
        if (firstUpper && secondUpper && !isupper(word[i])) return false;
        if (firstUpper && !secondUpper && isupper(word[i])) return false;
        if (!firstUpper && isupper(word[i])) return false;
    }

    return true;
}