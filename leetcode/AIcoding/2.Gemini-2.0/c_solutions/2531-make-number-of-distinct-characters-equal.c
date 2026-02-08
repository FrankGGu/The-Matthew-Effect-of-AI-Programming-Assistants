#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool makeEqual(char * word1, char * word2){
    int freq1[26] = {0};
    int freq2[26] = {0};

    for (int i = 0; word1[i] != '\0'; i++) {
        freq1[word1[i] - 'a']++;
    }

    for (int i = 0; word2[i] != '\0'; i++) {
        freq2[word2[i] - 'a']++;
    }

    int distinct1 = 0;
    for (int i = 0; i < 26; i++) {
        if (freq1[i] > 0) {
            distinct1++;
        }
    }

    int distinct2 = 0;
    for (int i = 0; i < 26; i++) {
        if (freq2[i] > 0) {
            distinct2++;
        }
    }

    for (int i = 0; i < 26; i++) {
        if (freq1[i] > 0 && freq2[i] == 0) {
            freq1[i]--;
            freq2[i]++;

            int new_distinct1 = 0;
            for (int j = 0; j < 26; j++) {
                if (freq1[j] > 0) {
                    new_distinct1++;
                }
            }

            int new_distinct2 = 0;
            for (int j = 0; j < 26; j++) {
                if (freq2[j] > 0) {
                    new_distinct2++;
                }
            }

            if (new_distinct1 == new_distinct2) {
                return true;
            }

            freq1[i]++;
            freq2[i]--;
        }
    }

    for (int i = 0; i < 26; i++) {
        if (freq2[i] > 0 && freq1[i] == 0) {
            freq2[i]--;
            freq1[i]++;

            int new_distinct1 = 0;
            for (int j = 0; j < 26; j++) {
                if (freq1[j] > 0) {
                    new_distinct1++;
                }
            }

            int new_distinct2 = 0;
            for (int j = 0; j < 26; j++) {
                if (freq2[j] > 0) {
                    new_distinct2++;
                }
            }

            if (new_distinct1 == new_distinct2) {
                return true;
            }
            freq2[i]++;
            freq1[i]--;
        }
    }

    if (distinct1 == distinct2)
        return true;

    return false;
}