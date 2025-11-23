#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int count = 0;

void backtrack(char *tiles, int *freq, int length) {
    for (int i = 0; i < 26; i++) {
        if (freq[i] == 0) continue;
        freq[i]--;
        count++;
        backtrack(tiles, freq, length);
        freq[i]++;
    }
}

int numTilePossibilities(char *tiles) {
    int freq[26] = {0};
    for (int i = 0; tiles[i]; i++) {
        freq[tiles[i] - 'A']++;
    }
    count = 0;
    backtrack(tiles, freq, strlen(tiles));
    return count;
}