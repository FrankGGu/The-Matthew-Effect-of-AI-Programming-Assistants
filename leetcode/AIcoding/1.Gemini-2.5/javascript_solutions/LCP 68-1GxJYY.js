var beautifulBouquet = function(flowers, k) {
    let left = 0;
    let maxLength = 0;
    const freqMap = new Map();
    let distinctCount = 0;

    for (let right = 0; right < flowers.length; right++) {
        const currentFlower = flowers[right];

        if (freqMap.get(currentFlower) === undefined || freqMap.get(currentFlower) === 0) {
            distinctCount++;
        }
        freqMap.set(currentFlower, (freqMap.get(currentFlower) || 0) + 1);

        while (distinctCount > k) {
            const leftFlower = flowers[left];
            freqMap.set(leftFlower, freqMap.get(leftFlower) - 1);
            if (freqMap.get(leftFlower) === 0) {
                distinctCount--;
            }
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
};