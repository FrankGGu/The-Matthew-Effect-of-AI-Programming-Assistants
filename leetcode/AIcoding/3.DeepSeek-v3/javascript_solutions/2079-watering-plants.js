var wateringPlants = function(plants, capacity) {
    let steps = 0;
    let currentWater = capacity;

    for (let i = 0; i < plants.length; i++) {
        if (currentWater < plants[i]) {
            steps += 2 * i;
            currentWater = capacity;
        }
        steps++;
        currentWater -= plants[i];
    }

    return steps;
};