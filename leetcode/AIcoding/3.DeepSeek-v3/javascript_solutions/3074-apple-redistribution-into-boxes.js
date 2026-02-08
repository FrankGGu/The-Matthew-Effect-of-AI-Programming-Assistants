var minimumBoxes = function(apple, capacity) {
    capacity.sort((a, b) => b - a);
    let totalApples = apple.reduce((sum, a) => sum + a, 0);
    let boxes = 0;
    let currentCapacity = 0;

    for (let cap of capacity) {
        currentCapacity += cap;
        boxes++;
        if (currentCapacity >= totalApples) {
            break;
        }
    }

    return boxes;
};