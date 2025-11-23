var isPossible = function(nums) {
    const freq = new Map();
    const tails = new Map();

    for (const num of nums) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    for (const num of nums) {
        if (!freq.has(num)) continue;
        if (tails.get(num - 1) > 0) {
            tails.set(num - 1, tails.get(num - 1) - 1);
            tails.set(num, (tails.get(num) || 0) + 1);
        } else if (freq.get(num) > 0 && freq.get(num + 1) > 0 && freq.get(num + 2) > 0) {
            freq.set(num, freq.get(num) - 1);
            freq.set(num + 1, freq.get(num + 1) - 1);
            freq.set(num + 2, freq.get(num + 2) - 1);
            tails.set(num + 2, (tails.get(num + 2) || 0) + 1);
        } else {
            return false;
        }
        freq.set(num, freq.get(num) - 1);
        if (freq.get(num) === 0) {
            freq.delete(num);
        }
    }
    return true;
};