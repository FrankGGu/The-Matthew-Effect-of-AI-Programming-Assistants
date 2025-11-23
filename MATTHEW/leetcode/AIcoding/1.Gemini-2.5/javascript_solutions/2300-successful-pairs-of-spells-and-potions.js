var successfulPairs = function(spells, potions, success) {
    potions.sort((a, b) => a - b);

    const result = [];
    const n = potions.length;

    for (let i = 0; i < spells.length; i++) {
        const spell = spells[i];
        let left = 0;
        let right = n - 1;
        let firstSuccessfulIndex = n; // Default to n, meaning no successful potion found

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            // Use BigInt for multiplication to prevent overflow for very large numbers,
            // though standard JS numbers handle up to 2^53-1 which is typically sufficient
            // for LeetCode constraints like 10^5 * 10^5 = 10^10.
            if (BigInt(spell) * BigInt(potions[mid]) >= BigInt(success)) {
                firstSuccessfulIndex = mid;
                right = mid - 1; // Try to find an even smaller potion
            } else {
                left = mid + 1; // This potion is too small, look in the right half
            }
        }
        result.push(n - firstSuccessfulIndex);
    }

    return result;
};