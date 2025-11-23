char* smallestPalindrome(char* s) {
    int count[26] = {0};
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        count[s[i] - 'a']++;
    }

    char* result = (char*)malloc((len + 1) * sizeof(char));
    result[len] = '\0';

    int left = 0, right = len - 1;
    for (int i = 0; i < 26; i++) {
        while (count[i] > 1) {
            result[left++] = 'a' + i;
            result[right--] = 'a' + i;
            count[i] -= 2;
        }
    }

    for (int i = 0; i < 26; i++) {
        if (count[i] == 1) {
            result[left] = 'a' + i;
            break;
        }
    }

    return result;
}