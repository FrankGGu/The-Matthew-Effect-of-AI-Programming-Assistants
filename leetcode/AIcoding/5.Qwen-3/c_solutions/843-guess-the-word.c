#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** wordlist;
    int wordlistSize;
    int* match;
} Game;

void findSecretWord(char** wordlist, int wordlistSize, int* match) {
    int i, j, k;
    for (i = 0; i < 10; i++) {
        int freq[26] = {0};
        for (j = 0; j < wordlistSize; j++) {
            if (match[j] != -1) {
                for (k = 0; k < 6; k++) {
                    freq[wordlist[j][k] - 'a']++;
                }
            }
        }
        int best = 0, bestIndex = 0;
        for (j = 0; j < wordlistSize; j++) {
            if (match[j] == -1) continue;
            int score = 0;
            for (k = 0; k < 6; k++) {
                score += freq[wordlist[j][k] - 'a'];
            }
            if (score > best) {
                best = score;
                bestIndex = j;
            }
        }
        int count[26] = {0};
        for (j = 0; j < wordlistSize; j++) {
            if (match[j] == -1) {
                int same = 0;
                for (k = 0; k < 6; k++) {
                    if (wordlist[bestIndex][k] == wordlist[j][k]) same++;
                }
                if (same == 0) continue;
                count[same]++;
            }
        }
        for (j = 0; j < wordlistSize; j++) {
            if (match[j] == -1) {
                int same = 0;
                for (k = 0; k < 6; k++) {
                    if (wordlist[bestIndex][k] == wordlist[j][k]) same++;
                }
                if (same == 0) continue;
                match[j] = same;
            }
        }
    }
}