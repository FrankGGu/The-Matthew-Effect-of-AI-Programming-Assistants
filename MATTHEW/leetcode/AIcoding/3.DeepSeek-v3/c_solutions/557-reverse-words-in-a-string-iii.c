char* reverseWords(char* s) {
    int start = 0, end = 0;
    int len = strlen(s);

    while (end < len) {
        while (end < len && s[end] != ' ') {
            end++;
        }

        int left = start;
        int right = end - 1;
        while (left < right) {
            char temp = s[left];
            s[left] = s[right];
            s[right] = temp;
            left++;
            right--;
        }

        start = end + 1;
        end = start;
    }

    return s;
}