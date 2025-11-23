#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubstrings(char * word, int k){
    int n = strlen(word);
    int count = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            int vowels[5] = {0};
            int consonants = 0;
            for (int l = i; l <= j; l++) {
                if (word[l] == 'a') vowels[0] = 1;
                else if (word[l] == 'e') vowels[1] = 1;
                else if (word[l] == 'i') vowels[2] = 1;
                else if (word[l] == 'o') vowels[3] = 1;
                else if (word[l] == 'u') vowels[4] = 1;
                else consonants++;
            }
            if (vowels[0] && vowels[1] && vowels[2] && vowels[3] && vowels[4] && consonants == k) {
                count++;
            }
        }
    }
    return count;
}