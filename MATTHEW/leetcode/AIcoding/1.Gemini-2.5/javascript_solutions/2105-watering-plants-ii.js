var wateringPlants = function(plants, capacityA, capacityB) {
    let refills = 0;
    let currentA = capacityA;
    let currentB = capacityB;
    let left = 0;
    let right = plants.length - 1;

    while (left <= right) {
        if (left === right) {
            // Middle plant
            // If neither person has enough water individually, one of them must refill.
            // It counts as one refill for this plant.
            if (currentA < plants[left] && currentB < plants[right]) {
                refills++;
            }
            break; // All plants are watered
        }

        // Person A waters from the left
        if (currentA < plants[left]) {
            refills++;
            currentA = capacityA; // Refill
        }
        currentA -= plants[left];
        left++;

        // Person B waters from the right
        if (currentB < plants[right]) {
            refills++;
            currentB = capacityB; // Refill
        }
        currentB -= plants[right];
        right--;
    }

    return refills;
};