var successfulPairs = function(potions, success, spells) {
    potions.sort((a, b) => a - b);
    let result = [];

    for (let i = 0; i < spells.length; i++) {
        let count = 0;
        let left = 0;
        let right = potions.length - 1;

        while (left <= right) {
            let mid = Math.floor((left + right) / 2);
            if (spells[i] * potions[mid] >= success) {
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