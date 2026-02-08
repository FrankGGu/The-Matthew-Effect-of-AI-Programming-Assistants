#include <string.h>
#include <stdlib.h>

int findWordsThatCanBeFormedByCharacters(char** words, int wordsSize, char* chars) {
    int chars_freq[26] = {0};
    for (int i = 0; chars[i] != '\0'; i++) {
        chars_freq[chars[i] - 'a']++;
    }

    int total_length = 0;

    for (int i = 0; i < wordsSize; i++) {
        char* current_word = words[i];
        int word_freq[26] = {0};
        int word_len = 0;

        for (int j = 0; current_word[j] != '\0'; j++) {
            word_freq[current_word[j] - 'a']++;
            word_len++;
        }

        int can_form = 1;
        for (int k = 0; k < 26; k++) {
            if (word_freq[k] > chars_freq[k]) {
                can_form = 0;
                break;
            }
        }

        if (can_form) {
            total_length += word_len;
        }
    }

    return total_length;
}