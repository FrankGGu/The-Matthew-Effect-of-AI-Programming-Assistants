int countVowelSubstrings(char * s, int k) {
    int n = strlen(s);
    int count = 0;
    int vowels[5] = {0}; // a, e, i, o, u
    int totalVowels = 0;
    int consonants = 0;

    for (int left = 0; left < n; left++) {
        memset(vowels, 0, sizeof(vowels));
        totalVowels = 0;
        consonants = 0;

        for (int right = left; right < n; right++) {
            if (s[right] == 'a' || s[right] == 'e' || s[right] == 'i' || s[right] == 'o' || s[right] == 'u') {
                if (vowels[s[right] - 'a'] == 0) {
                    totalVowels++;
                }
                vowels[s[right] - 'a']++;
            } else {
                consonants++;
            }

            if (totalVowels == 5 && consonants == k) {
                count++;
            }
        }
    }

    return count;
}