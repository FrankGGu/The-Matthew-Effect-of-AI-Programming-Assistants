#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numTilePossibilities(char * tiles){
    int count = 0;
    int len = strlen(tiles);
    int freq[26] = {0};
    for (int i = 0; i < len; i++) {
        freq[tiles[i] - 'A']++;
    }

    int backtrack(int *freq) {
        int sum = 0;
        for (int i = 0; i < 26; i++) {
            if (freq[i] > 0) {
                sum++;
                freq[i]--;
                sum += backtrack(freq);
                freq[i]++;
            }
        }
        return sum;
    }

    return backtrack(freq);
}