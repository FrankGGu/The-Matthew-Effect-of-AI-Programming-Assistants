#include <stdlib.h>

int numFriendRequests(int* ages, int agesSize) {
    int counts[121] = {0};
    for (int i = 0; i < agesSize; i++) {
        counts[ages[i]]++;
    }

    int totalRequests = 0;

    for (int ageA = 1; ageA <= 120; ageA++) {
        if (counts[ageA] == 0) {
            continue;
        }
        for (int ageB = 1; ageB <= 120; ageB++) {
            if (counts[ageB] == 0) {
                continue;
            }

            // Conditions for A sending a request to B:
            // 1. ageB > 0.5 * ageA + 7
            // 2. ageB <= ageA
            // 3. !(ageB > 100 && ageA < 100) - this condition is implicitly satisfied if ageB <= ageA,
            //    as if ageA < 100 then ageB must also be < 100, making (ageB > 100 && ageA < 100) false.
            //    If ageA >= 100, then ageA < 100 is false, making (ageB > 100 && ageA < 100) false.

            // Using integer arithmetic for condition 1:
            // ageB > 0.5 * ageA + 7  =>  2 * ageB > ageA + 14
            if (2 * ageB > ageA + 14 && ageB <= ageA) {
                if (ageA == ageB) {
                    totalRequests += counts[ageA] * (counts[ageA] - 1);
                } else {
                    totalRequests += counts[ageA] * counts[ageB];
                }
            }
        }
    }

    return totalRequests;
}