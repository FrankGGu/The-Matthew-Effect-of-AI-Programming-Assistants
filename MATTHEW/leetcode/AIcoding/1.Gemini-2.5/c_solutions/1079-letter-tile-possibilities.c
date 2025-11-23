#include <string.h>

int g_count;
int g_freq[26];

void backtrack() {
    for (int i = 0; i < 26; i++) {
        if (g_freq[i] > 0) {
            g_freq[i]--;
            g_count++;
            backtrack();
            g_freq[i]++;
        }
    }
}

int numTilePossibilities(char * tiles) {
    g_count = 0;
    for (int i = 0; i < 26; i++) {
        g_freq[i] = 0;
    }

    for (int i = 0; tiles[i] != '\0'; i++) {
        g_freq[tiles[i] - 'A']++;
    }

    backtrack();

    return g_count;
}