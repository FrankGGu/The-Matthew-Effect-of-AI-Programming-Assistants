#include <stdio.h>
#include <stdlib.h>

int countCompleteDayPairs(int* time, int timeSize) {
    int count = 0;
    for (int i = 0; i < timeSize; i++) {
        for (int j = i + 1; j < timeSize; j++) {
            if ((time[i] + time[j]) % 24 == 0) {
                count++;
            }
        }
    }
    return count;
}