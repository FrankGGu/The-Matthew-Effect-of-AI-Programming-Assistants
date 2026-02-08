function unequalTriplets(nums) {
    let count = 0;
    const n = nums.length;
    const freq = new Map();

    for (let num of nums) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    const uniqueNums = Array.from(freq.keys());
    const totalUnique = uniqueNums.length;

    for (let i = 0; i < totalUnique; i++) {
        for (let j = i + 1; j < totalUnique; j++) {
            for (let k = j + 1; k < totalUnique; k++) {
                count += freq.get(uniqueNums[i]) * freq.get(uniqueNums[j]) * freq.get(uniqueNums[k]);
            }
        }
    }

    return count;
}