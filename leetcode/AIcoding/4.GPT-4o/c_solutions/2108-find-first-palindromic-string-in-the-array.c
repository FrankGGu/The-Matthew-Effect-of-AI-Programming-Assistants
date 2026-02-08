char* firstPalindrome(char** words, int wordsSize) {
    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        int isPalindrome = 1;
        for (int j = 0; j < len / 2; j++) {
            if (words[i][j] != words[i][len - j - 1]) {
                isPalindrome = 0;
                break;
            }
        }
        if (isPalindrome) {
            return words[i];
        }
    }
    return "";
}