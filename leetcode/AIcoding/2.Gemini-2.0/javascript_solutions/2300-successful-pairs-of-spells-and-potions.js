var successfulPairs = function(spells, potions, success) {
    potions.sort((a, b) => a - b);
    const n = spells.length;
    const m = potions.length;
    const result = [];

    for (let i = 0; i < n; i++) {
        let count = 0;
        let left = 0;
        let right = m - 1;

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (spells[i] * potions[mid] >= success) {
                count = m - mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        result.push(count);
    }

    return result;
};