#include <stdio.h>
#include <stdlib.h>

int countTestedDevices(int* batteryPercentages, int batteryPercentagesSize) {
    int count = 0;
    for (int i = 0; i < batteryPercentagesSize; i++) {
        if (batteryPercentages[i] > 0) {
            count++;
            for (int j = i + 1; j < batteryPercentagesSize; j++) {
                batteryPercentages[j]--;
            }
        }
    }
    return count;
}