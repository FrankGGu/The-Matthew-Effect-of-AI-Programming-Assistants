char* firstPalindrome(char** words, int wordsSize) {
    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int left = 0;
        int right = strlen(word) - 1;
        int isPalindrome = 1;

        while (left < right) {
            if (word[left] != word[right]) {
                isPalindrome = 0;
                break;
            }
            left++;
            right--;
        }

        if (isPalindrome) {
            return word;
        }
    }

    return "";
}