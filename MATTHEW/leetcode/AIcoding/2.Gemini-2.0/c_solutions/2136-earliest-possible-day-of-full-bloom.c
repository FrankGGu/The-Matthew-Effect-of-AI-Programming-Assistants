#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int plantTime;
    int growTime;
} Seed;

int compareSeeds(const void *a, const void *b) {
    return ((Seed *)b)->growTime - ((Seed *)a)->growTime;
}

int earliestFullBloom(int *plantTime, int plantTimeSize, int *growTime, int growTimeSize) {
    Seed seeds[plantTimeSize];
    for (int i = 0; i < plantTimeSize; i++) {
        seeds[i].plantTime = plantTime[i];
        seeds[i].growTime = growTime[i];
    }

    qsort(seeds, plantTimeSize, sizeof(Seed), compareSeeds);

    int bloomDay = 0;
    int currentPlantingDay = 0;

    for (int i = 0; i < plantTimeSize; i++) {
        currentPlantingDay += seeds[i].plantTime;
        int currentBloomDay = currentPlantingDay + seeds[i].growTime;
        if (currentBloomDay > bloomDay) {
            bloomDay = currentBloomDay;
        }
    }

    return bloomDay;
}