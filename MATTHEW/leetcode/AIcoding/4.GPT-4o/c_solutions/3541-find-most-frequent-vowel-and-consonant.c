#include <stdio.h>
#include <string.h>

int mostFrequentChar(char *s, int isVowel) {
    int count[26] = {0};
    int maxCount = 0, maxChar = -1;
    char vowels[] = "aeiou";

    for (int i = 0; s[i]; i++) {
        char ch = s[i];
        if (isVowel && strchr(vowels, ch)) {
            count[ch - 'a']++;
            if (count[ch - 'a'] > maxCount || (count[ch - 'a'] == maxCount && ch < maxChar)) {
                maxCount = count[ch - 'a'];
                maxChar = ch;
            }
        } else if (!isVowel && !strchr(vowels, ch) && ch >= 'a' && ch <= 'z') {
            count[ch - 'a']++;
            if (count[ch - 'a'] > maxCount || (count[ch - 'a'] == maxCount && ch < maxChar)) {
                maxCount = count[ch - 'a'];
                maxChar = ch;
            }
        }
    }
    return maxChar;
}

char* findMostFrequent(char *s) {
    static char result[3];
    result[0] = mostFrequentChar(s, 1);
    result[1] = mostFrequentChar(s, 0);
    result[2] = '\0';
    return result;
}