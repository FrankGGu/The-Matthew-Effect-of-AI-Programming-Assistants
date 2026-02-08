var successfulPairs = function(spells, potions, success) {
    potions.sort((a, b) => a - b);
    const result = [];
    const n = potions.length;

    for (const spell of spells) {
        const target = Math.ceil(success / spell);
        let left = 0, right = n;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (potions[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        result.push(n - left);
    }

    return result;
};