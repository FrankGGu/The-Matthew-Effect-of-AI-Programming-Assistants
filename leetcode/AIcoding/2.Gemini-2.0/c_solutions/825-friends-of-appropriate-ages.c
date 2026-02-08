#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numFriendRequests(int* ages, int agesSize) {
    int count = 0;
    int ageCounts[121] = {0};
    for (int i = 0; i < agesSize; i++) {
        ageCounts[ages[i]]++;
    }

    for (int ageA = 1; ageA <= 120; ageA++) {
        for (int ageB = 1; ageB <= 120; ageB++) {
            if (ageCounts[ageA] == 0) continue;
            if (ageCounts[ageB] == 0) continue;

            if (ageB <= 0.5 * ageA + 7) continue;
            if (ageB > ageA) continue;
            if (ageB > 100 && ageA < 100) continue;

            if (ageA == ageB) {
                count += ageCounts[ageA] * (ageCounts[ageA] - 1);
            } else {
                count += ageCounts[ageA] * ageCounts[ageB];
            }
        }
    }

    return count;
}