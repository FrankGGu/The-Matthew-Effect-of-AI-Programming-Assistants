int wateringPlants(int* plants, int plantsSize, int capacityA, int capacityB) {
    int refills = 0;
    long long currentWaterA = capacityA;
    long long currentWaterB = capacityB;
    int left = 0;
    int right = plantsSize - 1;

    while (left < right) {
        // Alice waters plants[left]
        if (currentWaterA < plants[left]) {
            refills++;
            currentWaterA = capacityA;
        }
        currentWaterA -= plants[left];
        left++;

        // Bob waters plants[right]
        if (currentWaterB < plants[right]) {
            refills++;
            currentWaterB = capacityB;
        }
        currentWaterB -= plants[right];
        right--;
    }

    // If there is a middle plant (plantsSize is odd)
    if (left == right) {
        // Determine who waters the middle plant based on current water
        // Rule: "the one with more water waters it. If they have the same amount of water, Alice waters it."
        // Then, check if that person needs to refill.
        if (currentWaterA >= currentWaterB) { // Alice waters (or they have equal water)
            if (currentWaterA < plants[left]) {
                refills++;
            }
        } else { // Bob has more water
            if (currentWaterB < plants[left]) {
                refills++;
            }
        }
    }

    return refills;
}