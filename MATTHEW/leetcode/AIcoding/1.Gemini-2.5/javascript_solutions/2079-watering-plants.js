var wateringPlants = function(plants, capacity) {
    let steps = 0;
    let currentWater = capacity;
    const n = plants.length;

    for (let i = 0; i < n; i++) {
        if (currentWater < plants[i]) {
            // Not enough water, need to refill
            // Steps to go back to the river from the previous plant (position i-1)
            // The distance from plant (i-1) to river (-1) is (i-1) - (-1) = i
            // For i=0, this is 0, meaning we are already at the river or starting from there.
            steps += i; 

            // Refill watering can
            currentWater = capacity;

            // Steps to go from the river (-1) to the current plant (position i)
            // The distance from river (-1) to plant i is i - (-1) = i + 1
            steps += (i + 1);

            // Water the plant
            currentWater -= plants[i];
        } else {
            // Enough water, just move to the next plant
            // The distance from plant (i-1) to plant i is 1.
            // This also applies for i=0, moving from river (-1) to plant 0 is 1 step.
            steps += 1;

            // Water the plant
            currentWater -= plants[i];
        }
    }

    return steps;
};