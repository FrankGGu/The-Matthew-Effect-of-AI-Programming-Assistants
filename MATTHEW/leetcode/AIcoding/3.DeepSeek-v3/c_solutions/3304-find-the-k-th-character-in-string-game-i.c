char kthCharacter(int k) {
    char* s = (char*)malloc(1000000 * sizeof(char));
    s[0] = 'a';
    int len = 1;

    while (len < k) {
        for (int i = 0; i < len; i++) {
            s[len + i] = (s[i] == 'a') ? 'b' : 'a';
        }
        len *= 2;
    }

    char result = s[k - 1];
    free(s);
    return result;
}