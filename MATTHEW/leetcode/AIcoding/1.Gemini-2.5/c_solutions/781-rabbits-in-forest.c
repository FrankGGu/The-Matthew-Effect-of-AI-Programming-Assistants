#include <stdlib.h>

int numRabbits(int* answers, int answersSize) {
    if (answersSize == 0) {
        return 0;
    }

    int freq[1000] = {0}; 

    for (int i = 0; i < answersSize; i++) {
        freq[answers[i]]++;
    }

    int totalRabbits = 0;

    for (int i = 0; i < 1000; i++) {
        if (freq[i] == 0) {
            continue;
        }

        int count = freq[i];
        int groupSize = i + 1;

        int numGroups = (count + groupSize - 1) / groupSize;

        totalRabbits += numGroups * groupSize;
    }

    return totalRabbits;
}