int minimumTime(int* plants, int plantsSize, int capacityA, int capacityB) {
    int totalTime = 0;
    int currentA = 0, currentB = 0;
    int i = 0, waterA = 0, waterB = 0;

    while (i < plantsSize) {
        if (waterA == 0 && plants[i] > 0) {
            waterA = capacityA;
            totalTime += 1; // Time to reach the plant
        }
        if (waterB == 0 && plants[plantsSize - 1 - i] > 0) {
            waterB = capacityB;
            totalTime += 1; // Time to reach the plant
        }

        if (i < plantsSize && plants[i] > 0) {
            int needed = plants[i];
            if (waterA >= needed) {
                waterA -= needed;
                plants[i] = 0;
            } else {
                plants[i] -= waterA;
                waterA = 0;
            }
        }

        if (plantsSize - 1 - i >= 0 && plants[plantsSize - 1 - i] > 0) {
            int needed = plants[plantsSize - 1 - i];
            if (waterB >= needed) {
                waterB -= needed;
                plants[plantsSize - 1 - i] = 0;
            } else {
                plants[plantsSize - 1 - i] -= waterB;
                waterB = 0;
            }
        }

        if (i < plantsSize) {
            totalTime += 1; // Time to return to the river after watering
        }

        i++;
    }
    return totalTime;
}