var breakfastCombination = function(staple, drinks, x) {
    staple.sort((a, b) => a - b);

    const MOD = 1000000007;
    let count = 0;

    const findCountLE = (arr, target) => {
        let low = 0;
        let high = arr.length - 1;
        let ans_idx = -1;

        while (low <= high) {
            let mid = Math.floor(low + (high - low) / 2);
            if (arr[mid] <= target) {
                ans_idx = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans_idx + 1;
    };

    for (const drinkPrice of drinks) {
        const remainingCapacity = x - drinkPrice;

        if (remainingCapacity <= 0) { 
            continue;
        }

        const validStaplesCount = findCountLE(staple, remainingCapacity);
        count = (count + validStaplesCount) % MOD;
    }

    return count;
};