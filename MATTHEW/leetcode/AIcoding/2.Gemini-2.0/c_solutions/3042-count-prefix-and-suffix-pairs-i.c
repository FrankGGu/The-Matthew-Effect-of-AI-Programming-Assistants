#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countPrefixSuffixPairs(char ** words, int wordsSize){
    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            int len_i = strlen(words[i]);
            int len_j = strlen(words[j]);

            if (len_i > len_j) continue;

            int prefix_match = 1;
            for (int k = 0; k < len_i; k++) {
                if (words[i][k] != words[j][k]) {
                    prefix_match = 0;
                    break;
                }
            }

            if (!prefix_match) continue;

            int suffix_match = 1;
            for (int k = 0; k < len_i; k++) {
                if (words[i][k] != words[j][len_j - len_i + k]) {
                    suffix_match = 0;
                    break;
                }
            }

            if (suffix_match) {
                count++;
            }
        }
    }
    return count;
}