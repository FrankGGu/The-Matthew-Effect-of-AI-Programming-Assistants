var successfulPairs = function(spells, potions, success) {
    potions.sort((a, b) => a - b);
    const result = [];

    for (let spell of spells) {
        let count = 0;
        let left = 0, right = potions.length - 1;

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (spell * potions[mid] >= success) {
                count = potions.length - mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        result.push(count);
    }

    return result;
};