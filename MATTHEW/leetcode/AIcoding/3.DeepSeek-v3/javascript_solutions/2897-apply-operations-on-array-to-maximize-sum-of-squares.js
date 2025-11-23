var maxSum = function(nums, k) {
    const mod = 1e9 + 7;
    const bits = new Array(30).fill(0);

    for (const num of nums) {
        for (let i = 0; i < 30; i++) {
            if (num & (1 << i)) {
                bits[i]++;
            }
        }
    }

    let res = 0;
    for (let i = 0; i < k; i++) {
        let current = 0;
        for (let j = 0; j < 30; j++) {
            if (bits[j] > 0) {
                current |= (1 << j);
                bits[j]--;
            }
        }
        res = (res + current * current) % mod;
    }

    return res;
};