var wateringPlants = function(plants, capacity) {
    let steps = 0;
    let currentCapacity = capacity;
    for (let i = 0; i < plants.length; i++) {
        if (currentCapacity >= plants[i]) {
            steps++;
            currentCapacity -= plants[i];
        } else {
            steps += (i * 2);
            currentCapacity = capacity;
            steps++;
            currentCapacity -= plants[i];
        }
    }
    return steps;
};