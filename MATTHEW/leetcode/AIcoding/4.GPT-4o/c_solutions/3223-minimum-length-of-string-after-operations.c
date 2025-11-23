int minimumLength(char *s) {
    int left = 0, right = strlen(s) - 1;

    while (left < right) {
        if (s[left] == s[right]) {
            char currentChar = s[left];
            while (left <= right && s[left] == currentChar) left++;
            while (left <= right && s[right] == currentChar) right--;
        } else {
            break;
        }
    }

    return right - left + 1;
}