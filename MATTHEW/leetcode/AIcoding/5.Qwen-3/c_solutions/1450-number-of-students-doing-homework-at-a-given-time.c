#include <stdio.h>
#include <stdlib.h>

int busyStudent(int* startTime, int endTimeSize, int* endTime, int startTimeSize) {
    int count = 0;
    for (int i = 0; i < startTimeSize; i++) {
        if (startTime[i] <= endTime[i]) {
            count++;
        }
    }
    return count;
}