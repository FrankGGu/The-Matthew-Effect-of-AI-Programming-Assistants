bool canMakeSubsequence(char* str1, char* str2) {
    int i = 0, j = 0;
    int len1 = strlen(str1), len2 = strlen(str2);

    while (i < len1 && j < len2) {
        char next_char = (str1[i] - 'a' + 1) % 26 + 'a';
        if (str1[i] == str2[j] || next_char == str2[j]) {
            j++;
        }
        i++;
    }

    return j == len2;
}