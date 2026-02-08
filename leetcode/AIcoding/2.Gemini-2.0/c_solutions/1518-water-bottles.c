#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numWaterBottles(int numBottles, int numExchange){
    int drunk = numBottles;
    int empty = numBottles;

    while (empty >= numExchange) {
        int newBottles = empty / numExchange;
        drunk += newBottles;
        empty = empty % numExchange + newBottles;
    }

    return drunk;
}