function minimumSeconds(nums) {
    const n = nums.length;
    const next = new Array(n).fill(-1);
    const lastIndex = new Map();

    for (let i = 0; i < n; i++) {
        if (lastIndex.has(nums[i])) {
            next[lastIndex.get(nums[i])] = i;
        }
        lastIndex.set(nums[i], i);
    }

    for (let i = 0; i < n; i++) {
        if (lastIndex.has(nums[i])) {
            next[lastIndex.get(nums[i])] = i + n;
        }
    }

    let minSeconds = Infinity;

    for (let i = 0; i < n; i++) {
        let count = 0;
        let current = next[i];

        while (current !== -1 && count < n) {
            count++;
            current = next[current];
        }

        minSeconds = Math.min(minSeconds, n - count);
    }

    return minSeconds === Infinity ? -1 : minSeconds;
}