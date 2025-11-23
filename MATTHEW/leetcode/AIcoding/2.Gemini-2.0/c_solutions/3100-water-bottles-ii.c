#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int waterBottles(int numBottles, int numExchange) {
    int drank = numBottles;
    int empty = numBottles;
    while (empty >= numExchange) {
        int newBottles = empty / numExchange;
        drank += newBottles;
        empty = empty % numExchange + newBottles;
    }
    return drank;
}