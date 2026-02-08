#include <stdio.h>
#include <stdlib.h>

int timeRequiredToBuy(int* tickets, int ticketsSize) {
    int total_time = 0;
    for (int i = 0; i < ticketsSize; i++) {
        int min_val = (tickets[i] < tickets[0]) ? tickets[i] : tickets[0];
        total_time += min_val;
        if (i > 0 && tickets[i] == tickets[0]) {
            total_time--;
        }
    }
    return total_time;
}