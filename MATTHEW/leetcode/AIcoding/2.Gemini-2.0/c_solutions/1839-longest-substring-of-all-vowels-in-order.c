#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestBeautifulSubstring(char * word) {
    int n = strlen(word);
    int ans = 0;
    for (int i = 0; i < n; ++i) {
        if (word[i] == 'a') {
            int j = i;
            int vowels = 1;
            while (j + 1 < n) {
                if (word[j + 1] == word[j]) {
                    ++j;
                } else if (word[j + 1] > word[j]) {
                    if (word[j + 1] == 'e' && word[j] == 'a') {
                        ++vowels;
                    } else if (word[j + 1] == 'i' && word[j] == 'e') {
                        ++vowels;
                    } else if (word[j + 1] == 'o' && word[j] == 'i') {
                        ++vowels;
                    } else if (word[j + 1] == 'u' && word[j] == 'o') {
                        ++vowels;
                    } else {
                        break;
                    }
                    ++j;
                } else {
                    break;
                }
            }
            if (vowels == 5) {
                ans = fmax(ans, j - i + 1);
            }
            i = j;
        }
    }
    return ans;
}