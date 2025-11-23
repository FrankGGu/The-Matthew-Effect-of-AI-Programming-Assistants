var minimumBoxes = function(apple, capacity) {
    let totalApples = 0;
    for (let i = 0; i < apple.length; i++) {
        totalApples += apple[i];
    }

    capacity.sort((a, b) => b - a);

    let boxesUsed = 0;
    let currentCapacitySum = 0;

    for (let i = 0; i < capacity.length; i++) {
        currentCapacitySum += capacity[i];
        boxesUsed++;
        if (currentCapacitySum >= totalApples) {
            break;
        }
    }

    return boxesUsed;
};