#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int guess(const char *word);

void findSecretWord(char **wordlist, int wordlistSize, int maxGuesses) {
    int n = wordlistSize;
    int x = 0;
    char *guess_word = wordlist[0];

    for (int i = 0; i < 10; ++i) {
        int match = guess(guess_word);
        if (match == 6) return;

        char **new_wordlist = (char **)malloc(n * sizeof(char *));
        int new_size = 0;

        for (int j = 0; j < n; ++j) {
            int cur_match = 0;
            for (int k = 0; k < 6; ++k) {
                if (guess_word[k] == wordlist[j][k]) {
                    cur_match++;
                }
            }
            if (cur_match == match) {
                new_wordlist[new_size++] = wordlist[j];
            }
        }

        n = new_size;
        wordlist = new_wordlist;

        if (n > 0) {
            guess_word = wordlist[0];
        }
        else{
            return;
        }
    }
}