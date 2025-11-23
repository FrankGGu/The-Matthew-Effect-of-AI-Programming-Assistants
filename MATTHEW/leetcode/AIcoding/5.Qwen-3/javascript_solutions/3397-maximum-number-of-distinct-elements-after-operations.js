function maxDistinctElements(nums, m) {
    const freq = new Map();
    for (const num of nums) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    const counts = Array.from(freq.values()).sort((a, b) => b - a);

    let distinct = 0;
    for (const count of counts) {
        if (count <= m) {
            distinct += 1;
            m -= count;
        } else {
            distinct += 1;
            m -= 1;
        }
    }

    return distinct;
}