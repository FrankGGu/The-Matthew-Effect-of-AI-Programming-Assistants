var minimumRefill = function(plants, capacityA, capacityB) {
    let left = 0;
    let right = plants.length - 1;
    let refillCount = 0;
    let currentA = capacityA;
    let currentB = capacityB;

    while (left <= right) {
        if (left === right) {
            const max = Math.max(currentA, currentB);
            if (max < plants[left]) {
                refillCount++;
            }
            break;
        }

        if (currentA < plants[left]) {
            refillCount++;
            currentA = capacityA;
        }
        currentA -= plants[left];
        left++;

        if (currentB < plants[right]) {
            refillCount++;
            currentB = capacityB;
        }
        currentB -= plants[right];
        right--;
    }

    return refillCount;
};