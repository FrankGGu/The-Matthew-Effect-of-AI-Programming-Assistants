#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double averageWaitingTime(int** customers, int customersSize, int* customersColSize) {
    double total_waiting_time = 0;
    long long current_time = 0;
    for (int i = 0; i < customersSize; i++) {
        if (current_time <= customers[i][0]) {
            current_time = customers[i][0] + customers[i][1];
            total_waiting_time += (double)customers[i][1];
        } else {
            current_time += customers[i][1];
            total_waiting_time += (double)(current_time - customers[i][0]);
        }
    }
    return total_waiting_time / customersSize;
}