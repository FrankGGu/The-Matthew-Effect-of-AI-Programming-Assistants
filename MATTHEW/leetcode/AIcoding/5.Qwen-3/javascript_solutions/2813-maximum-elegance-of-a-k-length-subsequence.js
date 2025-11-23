function maximumElegance(nums, k) {
    const n = nums.length;
    const pairs = nums.map((num, i) => [num, i]);
    pairs.sort((a, b) => a[0] !== b[0] ? b[0] - a[0] : a[1] - b[1]);

    const selected = [];
    const freq = new Map();
    let elegance = 0;

    for (let i = 0; i < k; i++) {
        const num = pairs[i][0];
        selected.push(num);
        if (freq.has(num)) {
            elegance += 1;
        } else {
            elegance += 2;
        }
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    const remaining = pairs.slice(k);
    const candidates = [];

    for (const [num, idx] of remaining) {
        if (freq.has(num) && freq.get(num) > 1) {
            candidates.push([num, idx]);
        }
    }

    candidates.sort((a, b) => a[1] - b[1]);

    for (let i = 0; i < candidates.length && i < selected.length; i++) {
        const num = candidates[i][0];
        const original = selected[i];
        if (original !== num) {
            elegance += 1;
            freq.set(original, freq.get(original) - 1);
            freq.set(num, freq.get(num) + 1);
        }
    }

    return elegance;
}