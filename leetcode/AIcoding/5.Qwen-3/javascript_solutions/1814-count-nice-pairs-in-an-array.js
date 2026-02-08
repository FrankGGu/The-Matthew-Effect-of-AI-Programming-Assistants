function countNicePairs(nums) {
    const mod = 10 ** 9 + 7;
    const map = new Map();
    let count = 0;

    for (const num of nums) {
        let diff = num;
        let temp = num;
        while (temp > 0) {
            diff -= temp % 10;
            temp = Math.floor(temp / 10);
        }
        map.set(diff, (map.get(diff) || 0) + 1);
    }

    for (const val of map.values()) {
        count = (count + val * (val - 1) / 2) % mod;
    }

    return count;
}