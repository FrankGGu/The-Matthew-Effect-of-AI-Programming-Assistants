var maximumBeauty = function(flowers, newFlowers, target, full, partial) {
    flowers.sort((a, b) => a - b);
    const n = flowers.length;
    let prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + flowers[i];
    }

    let res = 0;
    let j = 0;
    for (let i = 0; i <= n; i++) {
        const remaining = newFlowers - (target * (n - i) - (prefix[n] - prefix[i]));
        if (remaining >= 0) {
            while (j < i && flowers[j] * j - prefix[j] <= remaining) {
                j++;
            }
            let min = 0;
            if (j > 0) {
                const total = prefix[j] + remaining;
                min = Math.min(Math.floor(total / j), target - 1);
            }
            res = Math.max(res, (n - i) * full + min * partial);
        }
        if (i < n && flowers[i] >= target) {
            break;
        }
    }
    return res;
};