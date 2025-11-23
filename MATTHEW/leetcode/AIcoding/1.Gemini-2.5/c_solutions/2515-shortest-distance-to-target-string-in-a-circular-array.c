#include <string.h>
#include <stdlib.h>

int shortestDistance(char **words, int wordsSize, char *target, int start) {
    int min_dist = wordsSize;

    for (int i = 0; i < wordsSize; i++) {
        if (strcmp(words[i], target) == 0) {
            int diff = abs(i - start);
            int current_dist = (diff < wordsSize - diff) ? diff : (wordsSize - diff);
            if (current_dist < min_dist) {
                min_dist = current_dist;
            }
        }
    }

    return min_dist;
}