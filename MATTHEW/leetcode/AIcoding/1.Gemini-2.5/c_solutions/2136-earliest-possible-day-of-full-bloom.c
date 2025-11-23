#include <stdlib.h> // For qsort

typedef struct {
    int plant;
    int grow;
} Flower;

int compareFlowers(const void *a, const void *b) {
    Flower *flowerA = (Flower *)a;
    Flower *flowerB = (Flower *)b;
    return flowerB->grow - flowerA->grow;
}

int earliestFullBloom(int* plantTime, int plantTimeSize, int* growTime, int growTimeSize) {
    if (plantTimeSize == 0) {
        return 0;
    }

    // Create an array of Flower structs
    Flower flowers[plantTimeSize];
    for (int i = 0; i < plantTimeSize; i++) {
        flowers[i].plant = plantTime[i];
        flowers[i].grow = growTime[i];
    }

    // Sort the flowers based on grow time in descending order
    qsort(flowers, plantTimeSize, sizeof(Flower), compareFlowers);

    long long currentPlantingTime = 0; // Total time spent planting so far
    long long maxBloomTime = 0;        // Maximum time any flower will be in full bloom

    // Iterate through the sorted flowers
    for (int i = 0; i < plantTimeSize; i++) {
        // Add the current flower's plant time to the total planting time
        currentPlantingTime += flowers[i].plant;

        // Calculate the bloom time for the current flower
        // It's the time it finishes planting plus its grow time
        long long bloomTime = currentPlantingTime + flowers[i].grow;

        // Update the maximum bloom time if the current flower blooms later
        if (bloomTime > maxBloomTime) {
            maxBloomTime = bloomTime;
        }
    }

    return (int)maxBloomTime;
}