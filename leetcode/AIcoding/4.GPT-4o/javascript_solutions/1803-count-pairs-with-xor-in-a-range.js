var countPairs = function(nums, low, high) {
    const countXORInRange = (nums, target) => {
        let count = 0;
        const prefixXOR = new Map();
        let currentXOR = 0;
        prefixXOR.set(0, 1);

        for (const num of nums) {
            currentXOR ^= num;
            for (let i = 0; i < 32; i++) {
                const requiredXOR = currentXOR ^ (1 << i);
                count += prefixXOR.get(requiredXOR) || 0;
            }
            prefixXOR.set(currentXOR, (prefixXOR.get(currentXOR) || 0) + 1);
        }
        return count;
    };

    return countXORInRange(nums, high) - countXORInRange(nums, low - 1);
};