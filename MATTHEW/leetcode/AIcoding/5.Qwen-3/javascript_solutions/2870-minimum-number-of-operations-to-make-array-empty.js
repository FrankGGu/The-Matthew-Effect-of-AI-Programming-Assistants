function minOperations(nums) {
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    let operations = 0;

    for (const key in count) {
        const freq = count[key];
        if (freq === 1) return -1;
        operations += Math.floor(freq / 3);
        if (freq % 3 !== 0) operations += 1;
    }

    return operations;
}