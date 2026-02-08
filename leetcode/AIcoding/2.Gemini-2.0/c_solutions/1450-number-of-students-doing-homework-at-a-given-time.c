#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int busyStudent(int* startTime, int startTimeSize, int* endTime, int endTimeSize, int queryTime) {
    int count = 0;
    for (int i = 0; i < startTimeSize; i++) {
        if (startTime[i] <= queryTime && queryTime <= endTime[i]) {
            count++;
        }
    }
    return count;
}