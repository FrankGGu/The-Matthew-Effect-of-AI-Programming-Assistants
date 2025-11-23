int countVowelSubstrings(char *s) {
    int count = 0, left = 0, right = 0, n = strlen(s);
    int vowels[128] = {0};

    while (right < n) {
        if (strchr("aeiou", s[right])) {
            vowels[s[right]]++;
            while (vowels[s[right]] > 1) {
                vowels[s[left]]--;
                left++;
            }
            count += right - left + 1;
        } else {
            memset(vowels, 0, sizeof(vowels));
            left = right + 1;
        }
        right++;
    }

    return count;
}