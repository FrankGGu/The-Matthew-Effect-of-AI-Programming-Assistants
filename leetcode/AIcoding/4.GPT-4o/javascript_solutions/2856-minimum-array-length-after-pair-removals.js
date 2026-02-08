function minimumArrayLength(nums) {
    let count = 0;
    const freq = new Map();

    for (const num of nums) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    for (const [_, val] of freq) {
        count += Math.floor(val / 2);
    }

    return nums.length - count * 2;
}