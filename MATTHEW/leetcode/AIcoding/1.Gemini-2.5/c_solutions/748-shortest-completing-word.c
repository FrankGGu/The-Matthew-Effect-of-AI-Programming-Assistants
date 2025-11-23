#include <string.h>
#include <ctype.h>
#include <limits.h>

char* shortestCompletingWord(char* licensePlate, char** words, int wordsSize) {
    int license_freq[26] = {0};

    for (int i = 0; licensePlate[i] != '\0'; i++) {
        if (isalpha(licensePlate[i])) {
            license_freq[tolower(licensePlate[i]) - 'a']++;
        }
    }

    int shortest_word_idx = -1;
    int min_len = INT_MAX;

    for (int i = 0; i < wordsSize; i++) {
        char* current_word = words[i];
        int word_freq[26] = {0};

        for (int j = 0; current_word[j] != '\0'; j++) {
            word_freq[current_word[j] - 'a']++;
        }

        int completes = 1;
        for (int k = 0; k < 26; k++) {
            if (word_freq[k] < license_freq[k]) {
                completes = 0;
                break;
            }
        }

        if (completes) {
            int current_len = strlen(current_word);
            if (current_len < min_len) {
                min_len = current_len;
                shortest_word_idx = i;
            }
        }
    }

    return words[shortest_word_idx];
}