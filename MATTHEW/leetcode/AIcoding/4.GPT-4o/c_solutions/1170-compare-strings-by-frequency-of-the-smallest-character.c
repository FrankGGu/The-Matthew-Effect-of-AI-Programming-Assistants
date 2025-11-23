#include <string.h>
#include <stdlib.h>

int get_min_char_freq(const char* str) {
    int freq[26] = {0};
    for (int i = 0; str[i] != '\0'; i++) {
        freq[str[i] - 'a']++;
    }
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            return freq[i];
        }
    }
    return 0;
}

int compare(const void* a, const void* b) {
    int freqA = get_min_char_freq(*(const char**)a);
    int freqB = get_min_char_freq(*(const char**)b);
    if (freqA != freqB) {
        return freqA - freqB;
    }
    return strcmp(*(const char**)a, *(const char**)b);
}

char** minimumFrequencyWords(char** words, int wordsSize, int* returnSize) {
    qsort(words, wordsSize, sizeof(char*), compare);
    *returnSize = wordsSize;
    return words;
}