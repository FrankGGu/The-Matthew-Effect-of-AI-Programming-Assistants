int maxVowels(char * s, int k) {
    int maxCount = 0, currentCount = 0;
    int vowelsCount = 0;
    char* vowels = "aeiou";

    for (int i = 0; s[i] != '\0'; i++) {
        if (strchr(vowels, s[i])) {
            currentCount++;
        }
        if (i >= k) {
            if (strchr(vowels, s[i - k])) {
                currentCount--;
            }
        }
        if (i >= k - 1) {
            if (currentCount > maxCount) {
                maxCount = currentCount;
            }
        }
    }
    return maxCount;
}