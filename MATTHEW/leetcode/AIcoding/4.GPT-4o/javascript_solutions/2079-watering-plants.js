var wateringPlants = function(plants, capacity) {
    let steps = 0;
    let currentWater = capacity;

    for (let i = 0; i < plants.length; i++) {
        if (currentWater < plants[i]) {
            steps += i * 2; // go back to the river
            currentWater = capacity; // refill
        }
        currentWater -= plants[i];
        steps++; // water the plant
    }

    return steps;
};