function maxConsecutive(floors) {
    let maxCount = 0;
    let currentCount = 0;
    let specialFloors = new Set(floors);

    for (let i = 1; i <= 100000; i++) {
        if (!specialFloors.has(i)) {
            currentCount++;
            maxCount = Math.max(maxCount, currentCount);
        } else {
            currentCount = 0;
        }
    }

    return maxCount;
}