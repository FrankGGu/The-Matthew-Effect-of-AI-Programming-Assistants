#include <string.h>

int isVowel(char c) {
    return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u');
}

int countVowelSubstrings(char * word) {
    int n = strlen(word);
    int count = 0;

    for (int i = 0; i < n; i++) {
        if (!isVowel(word[i])) {
            continue;
        }

        int freq[5] = {0}; // Frequencies for 'a', 'e', 'i', 'o', 'u'
        int distinctVowels = 0;

        for (int j = i; j < n; j++) {
            char current_char = word[j];

            if (!isVowel(current_char)) {
                break; 
            }

            int vowel_idx;
            if (current_char == 'a') vowel_idx = 0;
            else if (current_char == 'e') vowel_idx = 1;
            else if (current_char == 'i') vowel_idx = 2;
            else if (current_char == 'o') vowel_idx = 3;
            else vowel_idx = 4; // 'u'

            if (freq[vowel_idx] == 0) {
                distinctVowels++;
            }
            freq[vowel_idx]++;

            if (distinctVowels == 5) {
                count++;
            }
        }
    }

    return count;
}