#include <stdio.h>
#include <stdlib.h>

int numWaterBottles(int numBottles, int numExchange) {
    int total = numBottles;
    int empty = numBottles;
    while (empty >= numExchange) {
        int new = empty / numExchange;
        total += new;
        empty = (empty % numExchange) + new;
    }
    return total;
}