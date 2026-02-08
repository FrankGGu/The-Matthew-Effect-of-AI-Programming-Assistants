char *reverseVowels(char *s) {
    int left = 0, right = strlen(s) - 1;
    char *vowels = "aeiouAEIOU";
    while (left < right) {
        while (left < right && strchr(vowels, s[left]) == NULL) {
            left++;
        }
        while (left < right && strchr(vowels, s[right]) == NULL) {
            right--;
        }
        if (left < right) {
            char temp = s[left];
            s[left] = s[right];
            s[right] = temp;
            left++;
            right--;
        }
    }
    return s;
}