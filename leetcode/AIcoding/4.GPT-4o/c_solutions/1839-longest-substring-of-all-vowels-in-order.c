int longestVowelSubstring(char * s) {
    int maxLength = 0, currentLength = 0;
    char vowels[] = "aeiou";
    int index = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == vowels[index]) {
            currentLength++;
            index++;
            if (index == 5) {
                maxLength = currentLength > maxLength ? currentLength : maxLength;
                currentLength--;
                index--;
            }
        } else if (s[i] == 'a') {
            maxLength = currentLength > maxLength ? currentLength : maxLength;
            currentLength = 1;
            index = 1;
        } else {
            maxLength = currentLength > maxLength ? currentLength : maxLength;
            currentLength = 0;
            index = 0;
        }
    }

    return maxLength > currentLength ? maxLength : currentLength;
}