#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numRabbits(int* answers, int answersSize){
    int count = 0;
    int freq[1000] = {0};
    for (int i = 0; i < answersSize; i++) {
        freq[answers[i]]++;
    }

    for (int i = 0; i < 1000; i++) {
        if (freq[i] > 0) {
            int groupSize = i + 1;
            int numGroups = (freq[i] + groupSize - 1) / groupSize;
            count += numGroups * groupSize;
        }
    }

    return count;
}