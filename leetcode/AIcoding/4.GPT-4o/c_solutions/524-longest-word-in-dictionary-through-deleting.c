char* findLongestWord(char* s, char** d, int dSize) {
    char* longest = "";

    for (int i = 0; i < dSize; i++) {
        char* word = d[i];
        int j = 0, k = 0;

        while (s[j] && word[k]) {
            if (s[j] == word[k]) {
                k++;
            }
            j++;
        }

        if (k == strlen(word)) {
            if (strlen(word) > strlen(longest) || 
                (strlen(word) == strlen(longest) && strcmp(word, longest) < 0)) {
                longest = word;
            }
        }
    }

    return longest;
}