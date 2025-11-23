int isVowel(char c) {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
}

int countVowelStrings(char **words, int wordsSize, int left, int right) {
    int count = 0;
    for (int i = left; i <= right; i++) {
        int len = strlen(words[i]);
        if (isVowel(words[i][0]) && isVowel(words[i][len - 1])) {
            count++;
        }
    }
    return count;
}