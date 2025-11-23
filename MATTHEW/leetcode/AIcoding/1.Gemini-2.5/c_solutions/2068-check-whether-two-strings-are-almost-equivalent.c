#include <stdbool.h>
#include <string.h>
#include <stdlib.h> // For abs

bool checkAlmostEquivalent(char * word1, char * word2){
    int freq1[26] = {0};
    int freq2[26] = {0};

    int len1 = strlen(word1);
    int len2 = strlen(word2);

    for (int i = 0; i < len1; i++) {
        freq1[word1[i] - 'a']++;
    }

    for (int i = 0; i < len2; i++) {
        freq2[word2[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if (abs(freq1[i] - freq2[i]) > 3) {
            return false;
        }
    }

    return true;
}