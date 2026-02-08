#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int shortestDistance(char ** words, int wordsSize, char * target, int startIndex){
    int minDist = INT_MAX;
    for (int i = 0; i < wordsSize; i++) {
        if (strcmp(words[i], target) == 0) {
            int dist1 = abs(i - startIndex);
            int dist2 = wordsSize - dist1;
            int dist = (dist1 < dist2) ? dist1 : dist2;
            if (dist < minDist) {
                minDist = dist;
            }
        }
    }
    return minDist;
}