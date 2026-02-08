int wateringPlants(int* plants, int plantsSize, int capacity) {
    long long steps = 0;
    long long current_water = capacity; // Use long long for current_water to match capacity type and prevent potential issues

    for (int i = 0; i < plantsSize; i++) {
        // Step 1: Move to the current plant 'i' from the previous location.
        // This is always 1 step, whether from the river (for i=0) or from the previous plant (i-1).
        steps++; 

        // Step 2: Check if refill is needed before watering plant 'i'.
        if (current_water < plants[i]) {
            // If refill is needed:
            // a. Walk back to the river from plant 'i'. This takes (i - (-1)) = (i + 1) steps.
            // b. Refill the watering can to full capacity.
            // c. Walk back to plant 'i' from the river. This takes (i - (-1)) = (i + 1) steps.
            // Total steps for refill round trip: 2 * (i + 1)
            steps += 2 * (i + 1);
            current_water = capacity; // Refill the can
        }

        // Step 3: Water the plant.
        current_water -= plants[i];
    }

    return (int)steps; // Cast to int as the problem expects int return, and steps will fit in int for given constraints.
}