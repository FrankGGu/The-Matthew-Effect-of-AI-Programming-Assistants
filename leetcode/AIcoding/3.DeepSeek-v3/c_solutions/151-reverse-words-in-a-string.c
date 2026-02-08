void reverse(char* s, int left, int right) {
    while (left < right) {
        char temp = s[left];
        s[left] = s[right];
        s[right] = temp;
        left++;
        right--;
    }
}

char* reverseWords(char* s) {
    int len = strlen(s);

    int i = 0, j = 0;
    while (i < len) {
        while (i < len && s[i] == ' ') i++;
        if (i < len && j > 0) s[j++] = ' ';
        int start = j;
        while (i < len && s[i] != ' ') s[j++] = s[i++];
        reverse(s, start, j - 1);
    }
    s[j] = '\0';

    reverse(s, 0, j - 1);
    return s;
}