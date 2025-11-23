#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int poorPigs(int buckets, int minutesToDie, int minutesToTest) {
    if (buckets == 1) return 0;
    int pigs = 0;
    int states = minutesToTest / minutesToDie + 1;
    while (pow(states, pigs) < buckets) {
        pigs++;
    }
    return pigs;
}