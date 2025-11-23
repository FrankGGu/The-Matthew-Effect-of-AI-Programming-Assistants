char* smallestPalindrome(char* s) {
    int n = strlen(s);
    int count[26] = {0};
    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }

    char* result = (char*)malloc((n + 1) * sizeof(char));
    result[n] = '\0';

    int left = 0, right = n - 1;
    int odd_char = -1;

    for (int i = 0; i < 26; i++) {
        while (count[i] >= 2) {
            result[left++] = 'a' + i;
            result[right--] = 'a' + i;
            count[i] -= 2;
        }
        if (count[i] == 1) {
            odd_char = i;
        }
    }

    if (left == right + 1) {
        return result;
    }

    if (odd_char != -1) {
        result[left] = 'a' + odd_char;
    } else {
        for (int i = 0; i < 26; i++) {
            if (count[i] > 0) {
                result[left] = 'a' + i;
                break;
            }
        }
    }

    return result;
}