#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countBeautifulSubstrings(char * s, int k){
    int n = strlen(s);
    int count = 0;
    for (int i = 0; i < n; i++) {
        int vowels = 0;
        int consonants = 0;
        for (int j = i; j < n; j++) {
            if (s[j] == 'a' || s[j] == 'e' || s[j] == 'i' || s[j] == 'o' || s[j] == 'u') {
                vowels++;
            } else {
                consonants++;
            }
            if (vowels == consonants && (vowels * consonants) % k == 0) {
                count++;
            }
        }
    }
    return count;
}