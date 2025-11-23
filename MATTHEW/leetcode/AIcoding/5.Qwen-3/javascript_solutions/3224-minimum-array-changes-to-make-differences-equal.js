function minChanges(nums, k) {
    const n = nums.length;
    const freq = new Array(16).fill(0);
    for (let i = 0; i < n; i++) {
        const x = nums[i];
        for (let j = 0; j < 16; j++) {
            if ((x >> j) & 1) {
                freq[j]++;
            }
        }
    }

    let res = 0;
    for (let j = 0; j < 16; j++) {
        const cnt = freq[j];
        if (cnt % 2 === 1) {
            res++;
        }
    }

    return res;
}