#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int calculateDelayedArrivalTime(int arrivalTime, int delayedTime) {
    return (arrivalTime + delayedTime) % 24;
}