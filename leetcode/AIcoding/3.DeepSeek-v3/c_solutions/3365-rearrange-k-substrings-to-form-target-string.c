bool canRearrange(char* s, char* target, int k) {
    int len = strlen(s);
    if (len != strlen(target)) return false;

    for (int i = 0; i < k; i++) {
        int count[26] = {0};
        for (int j = i; j < len; j += k) {
            count[s[j] - 'a']++;
            count[target[j] - 'a']--;
        }
        for (int c = 0; c < 26; c++) {
            if (count[c] != 0) return false;
        }
    }
    return true;
}