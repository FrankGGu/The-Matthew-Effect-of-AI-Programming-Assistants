bool isVowel(char c) {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
}

int countVowelSubstrings(char* word) {
    int count = 0;
    int len = strlen(word);

    for (int i = 0; i < len; i++) {
        int vowels[26] = {0};
        int vowelCount = 0;

        for (int j = i; j < len; j++) {
            if (!isVowel(word[j])) {
                break;
            }

            if (vowels[word[j] - 'a'] == 0) {
                vowelCount++;
            }
            vowels[word[j] - 'a']++;

            if (vowelCount == 5) {
                count++;
            }
        }
    }

    return count;
}