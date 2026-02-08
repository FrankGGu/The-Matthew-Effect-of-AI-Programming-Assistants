#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long waysToBuyPensPencils(int totalMoney, int penCost, int pencilCost) {
    long long ways = 0;
    for (int i = 0; i * penCost <= totalMoney; i++) {
        ways += (totalMoney - i * penCost) / pencilCost + 1;
    }
    return ways;
}