#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int similarPairs(char ** words, int wordsSize){
    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            bool similar = true;
            bool set1[26] = {false};
            bool set2[26] = {false};
            for (int k = 0; words[i][k] != '\0'; k++) {
                set1[words[i][k] - 'a'] = true;
            }
            for (int k = 0; words[j][k] != '\0'; k++) {
                set2[words[j][k] - 'a'] = true;
            }
            for (int k = 0; k < 26; k++) {
                if (set1[k] != set2[k]) {
                    similar = false;
                    break;
                }
            }
            if (similar) {
                count++;
            }
        }
    }
    return count;
}