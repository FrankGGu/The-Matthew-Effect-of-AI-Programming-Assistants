#include <stdio.h>
#include <stdlib.h>

int findDelayedArrivalTime(int arrivalTime, int delayedTime) {
    return (arrivalTime + delayedTime) % 24;
}