bool canBeEqual(char * target, char * arr) {
    int count[26] = {0};
    while (*target) {
        count[*target - 'a']++;
        target++;
    }
    while (*arr) {
        count[*arr - 'a']--;
        arr++;
    }
    for (int i = 0; i < 26; i++) {
        if (count[i] != 0) return false;
    }
    return true;
}