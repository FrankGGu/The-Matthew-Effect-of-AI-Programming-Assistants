function numberOfPairs(nums) {
    const count = {};
    let pairs = 0;
    let leftovers = 0;

    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    for (const key in count) {
        pairs += Math.floor(count[key] / 2);
        leftovers += count[key] % 2;
    }

    return [pairs, leftovers];
}