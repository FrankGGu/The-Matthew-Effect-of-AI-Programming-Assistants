#include <stdio.h>
#include <stdlib.h>

int poorPigs(int buckets, int minutesToDie, int minutesToTest) {
    int pigs = 0;
    int time = minutesToTest / minutesToDie;
    while (pow(time + 1, pigs) < buckets) {
        pigs++;
    }
    return pigs;
}