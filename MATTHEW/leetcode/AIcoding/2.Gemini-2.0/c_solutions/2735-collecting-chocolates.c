#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long minCost(int* costs, int costsSize, int money) {
    long long min_cost = LLONG_MAX;
    for (int i = 0; i < (1 << costsSize); i++) {
        long long current_cost = 0;
        int current_money = money;
        for (int j = 0; j < costsSize; j++) {
            if ((i >> j) & 1) {
                current_cost += costs[j];
                current_money--;
            }
        }
        if (current_money >= 0) {
            if (current_cost < min_cost) {
                min_cost = current_cost;
            }
        }
    }
    return min_cost == LLONG_MAX ? -1 : min_cost;
}