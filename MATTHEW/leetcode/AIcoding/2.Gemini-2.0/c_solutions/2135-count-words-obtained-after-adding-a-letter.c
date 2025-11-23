#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countWords(char ** startWords, int startWordsSize, char ** targetWords, int targetWordsSize){
    int count = 0;
    int *start_masks = (int *)malloc(sizeof(int) * startWordsSize);
    for (int i = 0; i < startWordsSize; i++) {
        int mask = 0;
        for (int j = 0; startWords[i][j] != '\0'; j++) {
            mask |= (1 << (startWords[i][j] - 'a'));
        }
        start_masks[i] = mask;
    }

    for (int i = 0; i < targetWordsSize; i++) {
        int target_mask = 0;
        for (int j = 0; targetWords[i][j] != '\0'; j++) {
            target_mask |= (1 << (targetWords[i][j] - 'a'));
        }

        for (int j = 0; j < 26; j++) {
            if (!(target_mask & (1 << j))) {
                int new_mask = target_mask | (1 << j);
                for (int k = 0; k < startWordsSize; k++) {
                    if (new_mask == start_masks[k]) {
                        count++;
                        goto next_target;
                    }
                }
            }
        }
        next_target:;
    }

    free(start_masks);
    return count;
}