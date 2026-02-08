#include <stdio.h>
#include <stdlib.h>

long long waysToBuyPensPencils(int total, int cost1, int cost2) {
    long long count = 0;
    for (int i = 0; i * cost1 <= total; i++) {
        int remaining = total - i * cost1;
        count += remaining / cost2 + 1;
    }
    return count;
}