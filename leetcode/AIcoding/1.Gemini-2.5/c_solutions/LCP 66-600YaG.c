#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

char* minBooths(char** words, int wordsSize) {
    int global_freq[26] = {0};

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int current_word_freq[26] = {0};

        for (int j = 0; j < strlen(word); j++) {
            current_word_freq[word[j] - 'a']++;
        }

        for (int k = 0; k < 26; k++) {
            global_freq[k] = max(global_freq[k], current_word_freq[k]);
        }
    }

    int total_length = 0;
    for (int i = 0; i < 26; i++) {
        total_length += global_freq[i];
    }

    char* result = (char*)malloc((total_length + 1) * sizeof(char));
    if (result == NULL) {
        return NULL;
    }

    int current_pos = 0;
    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < global_freq[i]; j++) {
            result[current_pos++] = (char)('a' + i);
        }
    }
    result[current_pos] = '\0';

    return result;
}