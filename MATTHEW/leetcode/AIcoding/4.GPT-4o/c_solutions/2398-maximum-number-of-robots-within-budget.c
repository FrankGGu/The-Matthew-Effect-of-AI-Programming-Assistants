#include <stdio.h>

int maximumRobots(int* chargeTimes, int chargeTimesSize, int budget) {
    int left = 0, right = 0, totalCharge = 0, maxRobots = 0;
    int k = 0;
    int* window = (int*)malloc(chargeTimesSize * sizeof(int));

    while (right < chargeTimesSize) {
        totalCharge += chargeTimes[right];
        window[k++] = chargeTimes[right++];

        while (totalCharge + (right - left) * window[k - 1] > budget) {
            totalCharge -= chargeTimes[left++];
        }

        maxRobots = fmax(maxRobots, right - left);
    }

    free(window);
    return maxRobots;
}